require_relative './test_helper'
require 'computer'
require 'board'
require 'game_state'
require 'board_mapper'

# Mock out dependencies on Board, GameState and BoardMapper et all

class ComputerTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_can_get_list_of_available_moves
    computer = Computer.new("x")
    marked_squares = {
      :a2 => "x", :b3 => "x", :c2 => "x"
    }
    @board.board.merge!(marked_squares)

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
    skip
    computer = Computer.new("x")
    @board.board = {
      :a1 => "o", :c2 => "o", :c3 => "o",
      :a3 => "x", :b1 => "x", :c1 => "x"
    }

    # @board.mark("a1", "o")
    # @board.mark("c2", "o")
    # @board.mark("c3", "o")

    # @board.mark("a3", "x")
    # @board.mark("b1", "x")
    # @board.mark("c1", "x")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)

    assert_equal "b2", move
  end

  def test_select_winning_move_depth
    skip
    computer = Computer.new("o")
    @board.board = {
      :c1 => "x", :c2 => "x",
      :a2 => "o", :b3 => "o", :c3 => "o"
    }

    # @board.mark("c1", "x")
    # @board.mark("c2", "x")

    # @board.mark("a2", "o")
    # @board.mark("b3", "o")
    # @board.mark("c3", "o")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)

    assert_equal "a3", move
  end

  def test_computer_marks_best_move
    skip
    computer = Computer.new("o")
    @board = {
      :c1 => "x", :c2 => "x",
      :a2 => "o", :b3 => "o", :c3 => "o"
    }

    # @board.mark("c1", "x")
    # @board.mark("c2", "x")

    # @board.mark("a2", "o")
    # @board.mark("b3", "o")
    # @board.mark("c3", "o")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)
    computer.make_move(@board, move)

    tile = BoardMapper.map_string(@board, move)

    coord = BoardMapper.map_coordinate(tile.x, tile.y)
    assert_equal true, @board.marked?(coord)
    assert_equal "o", @board.get(coord)
  end
end
