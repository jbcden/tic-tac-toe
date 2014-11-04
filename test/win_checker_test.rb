require_relative './test_helper'
require 'win_checker'

class WinCheckerTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_will_always_return_false_if_min_turns_is_not_met
    @board[1][0].mark("x")
    @board[1][2].mark("x")
    @board[1][4].mark("x")

    assert_equal false, WinChecker.end_state?(@board, 1)
    assert_equal false, WinChecker.end_state?(@board, 2)
    assert_equal false, WinChecker.end_state?(@board, 3)
    assert_equal false, WinChecker.end_state?(@board, 4)
  end

  def test_will_end_when_a_row_win_condition_is_met
    @board[1][0].mark("x")
    @board[1][2].mark("x")
    @board[1][4].mark("x")

    assert_equal true, WinChecker.end_state?(@board, 5)
  end

  def test_will_end_when_a_column_win_condition_is_met
    @board[0][2].mark("x")
    @board[1][2].mark("x")
    @board[2][2].mark("x")

    assert_equal true, WinChecker.end_state?(@board, 5)
  end

  def test_will_end_when_a_left_diagonal_win_condition_is_met
    @board[0][0].mark("x")
    @board[1][2].mark("x")
    @board[2][4].mark("x")

    assert_equal true, WinChecker.end_state?(@board, 5)
  end

  def test_will_end_when_a_right_diagonal_win_condition_is_met
    @board[0][4].mark("x")
    @board[1][2].mark("x")
    @board[2][0].mark("x")

    assert_equal true, WinChecker.end_state?(@board, 5)
  end
end
