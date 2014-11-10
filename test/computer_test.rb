require_relative './test_helper'
require 'computer'
require 'board'

class ComputerTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_can_get_list_of_available_moves
    @board[0][1].mark("x")
    @board[1][2].mark("x")
    @board[2][1].mark("x")

    available_moves = Computer.available_moves(@board)

    refute_includes available_moves, @board[0][1]
    refute_includes available_moves, @board[1][2]
    refute_includes available_moves, @board[2][1]

    assert_includes available_moves, @board[0][0]
    assert_includes available_moves, @board[0][2]
    assert_includes available_moves, @board[1][0]
    assert_includes available_moves, @board[1][1]
    assert_includes available_moves, @board[2][0]
    assert_includes available_moves, @board[2][2]
  end

  def test_select_winning_move
    @board[0][0].mark("o")
    @board[2][1].mark("o")
    @board[2][2].mark("o")

    @board[0][2].mark("x")
    @board[1][0].mark("x")
    @board[2][0].mark("x")

    move = Computer.make_move(@board, 7, "x")

    assert_equal 1, move.xval
    assert_equal 1, move.yval
  end

  def test_select_winning_move_depth
    @board[2][0].mark("x")
    @board[2][1].mark("x")

    @board[0][1].mark("o")
    @board[1][2].mark("o")
    @board[2][2].mark("o")

    move = Computer.make_move(@board, 7, "x")

    assert_equal 0, move.xval
    assert_equal 2, move.yval
  end
end
