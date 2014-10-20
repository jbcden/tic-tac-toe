require_relative './test_helper'
require 'board'

class BoardTest < MiniTest::Test
  def test_board_takes_a_height_and_length
    board = Board.new(3,3)
    assert_equal board.height, 3
    assert_equal board.width, 3
  end

  def test_internal_board_array_dimensions
    actual = Board.new(4,5)
    assert_equal 5, actual.board.size
    assert_equal 7, actual.board[0].size
  end

  def test_board_is_set_correctly
    actual = Board.new(5,6)

    assert_equal '_', actual.board[0][0].symbol
    assert_equal '_', actual.board[1][2].symbol
    assert_equal '_', actual.board[2][4].symbol
    assert_equal '_', actual.board[3][8].symbol
    assert_equal '_', actual.board[4][0].symbol

    assert_equal '|', actual.board[0][1].symbol
    assert_equal '|', actual.board[0][3].symbol
    assert_equal '|', actual.board[0][5].symbol
    assert_equal '|', actual.board[0][7].symbol

    assert_equal ' ', actual.board[5][0].symbol
    assert_equal ' ', actual.board[5][2].symbol
    assert_equal ' ', actual.board[5][4].symbol
  end
end
