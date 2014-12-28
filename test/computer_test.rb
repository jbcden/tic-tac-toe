require_relative './test_helper'
require 'computer'
require 'board'

class ComputerTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_can_get_list_of_available_moves
    computer = Computer.new("x")
    marked_squares = {
      :a1 => " ", :a2 => "x", :a3 => " ",
      :b1 => " ", :b2 => " ", :b3 => "x",
      :c1 => " ", :c2 => "x", :c3 => " "
    }
    @board.board = marked_squares

    available_moves = computer.available_moves(@board)

    refute_includes available_moves, "a2"
    refute_includes available_moves, "b3"
    refute_includes available_moves, "c2"

    assert_includes available_moves, "a1"
    assert_includes available_moves, "a3"
    assert_includes available_moves, "b1"
    assert_includes available_moves, "b2"
    assert_includes available_moves, "c1"
    assert_includes available_moves, "c3"
  end

  def test_select_winning_move
    computer = Computer.new("x")
    marked_squares = {
      :a1 => "o", :a2 => " ", :a3 => "x",
      :b1 => "x", :b2 => " ", :b3 => " ",
      :c1 => "x", :c2 => "o", :c3 => "o",
    }

    @board.board = marked_squares

    move = computer.calculate_best_move(@board)

    assert_equal "b2", move
  end

  def test_select_winning_move_depth
    computer = Computer.new("o")
    marked_squares = {
      :a1 => " ", :a2 => "o", :a3 => " ",
      :b1 => " ", :b2 => " ", :b3 => "o",
      :c1 => "x", :c2 => "x", :c3 => "o"
    }

    @board.board = marked_squares

    move = computer.calculate_best_move(@board)

    assert_equal "a3", move
  end

  def test_computer_marks_best_move
    computer = Computer.new("o")
    marked_squares = {
      :a1 => " ", :a2 => "o", :a3 => " ",
      :b1 => " ", :b2 => " ", :b3 => "o",
      :c1 => "x", :c2 => "x", :c3 => "o"
    }

    @board.board = marked_squares

    move = computer.calculate_best_move(@board)
    computer.make_move(@board, move)

    assert_equal true, @board.marked?(move)
    assert_equal "o", @board.get(move)
  end

  def test_computer_selects_corner_if_first
    computer = Computer.new("o")
    move = computer.calculate_best_move(@board)
  end
end
