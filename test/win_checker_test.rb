require_relative './test_helper'
require 'win_checker'

class WinCheckerTest < MiniTest::Test

  def test_will_end_when_a_row_win_condition_is_met
    board = Board.new(3,3)

    board.mark("b1", "x")
    board.mark("b2", "x")
    board.mark("b3", "x")

    assert_equal "x", WinChecker.call(board)
  end

  def test_will_end_when_a_column_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a3", "x")
    board.mark("b3", "x")
    board.mark("c3", "x")

    assert_equal "x", WinChecker.call(board)
  end

  def test_will_end_when_a_left_diagonal_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a1", "x")
    board.mark("b2", "x")
    board.mark("c3", "x")

    assert_equal "x", WinChecker.call(board)
  end

  def test_will_end_when_a_right_diagonal_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a3", "x")
    board.mark("b2", "x")
    board.mark("c1", "x")

    assert_equal "x", WinChecker.call(board)
  end

  def test_cat_is_winner_when_board_is_full
    board = Board.new(3,3)

    board.mark("a1", "o")
    board.mark("a2", "o")
    board.mark("a3", "x")
    board.mark("b1", "x")
    board.mark("b2", "x")
    board.mark("b3", "o")
    board.mark("c1", "o")
    board.mark("c2", "x")
    board.mark("c3", "o")

    assert_equal "cat", WinChecker.call(board)
  end
end
