require_relative './test_helper'
require 'computer'

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

  def test_must_score_each_available_tile
    skip
    @board[0][0].mark("o")
    @board[2][1].mark("o")
    @board[2][2].mark("o")

    @board[0][2].mark("x")
    @board[1][0].mark("x")
    @board[2][0].mark("x")

    scored_board = Computer.score(@board)

    assert_equal -1, scored_board[:a2]
    assert_equal -1, scored_board[:b3]

    assert_equal 1, scored_board[:a2]
  end
end
