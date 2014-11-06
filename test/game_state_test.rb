require_relative './test_helper'
require 'game_state'

class GameStateTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_will_always_return_false_if_min_turns_is_not_met
    @board[1][0].mark("x")
    @board[1][1].mark("x")
    @board[1][2].mark("x")
    game1 = GameState.new(@board, 1, "x")
    game2 = GameState.new(@board, 2, "x")
    game3 = GameState.new(@board, 3, "x")
    game4 = GameState.new(@board, 4, "x")

    assert_equal false, game1.end_state?
    assert_equal false, game2.end_state?
    assert_equal false, game3.end_state?
    assert_equal false, game4.end_state?
  end

  def test_will_end_when_a_row_win_condition_is_met
    @board[1][0].mark("x")
    @board[1][1].mark("x")
    @board[1][2].mark("x")
    game = GameState.new(@board, 5, "x")

    assert_equal "x", game.end_state?
  end

  def test_will_end_when_a_column_win_condition_is_met
    @board[0][2].mark("x")
    @board[1][2].mark("x")
    @board[2][2].mark("x")
    game = GameState.new(@board, 5, "x")

    assert_equal "x", game.end_state?
  end

  def test_will_end_when_a_left_diagonal_win_condition_is_met
    @board[0][0].mark("x")
    @board[1][1].mark("x")
    @board[2][2].mark("x")
    game = GameState.new(@board, 5, "x")

    assert_equal "x", game.end_state?
  end

  def test_will_end_when_a_right_diagonal_win_condition_is_met
    @board[0][2].mark("x")
    @board[1][1].mark("x")
    @board[2][0].mark("x")
    game = GameState.new(@board, 5, "x")

    assert_equal "x", game.end_state?
  end
end
