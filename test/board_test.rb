require_relative './test_helper'
require 'board'

class BoardTest < MiniTest::Test
  def test_board_takes_a_height_and_length
    board = Board.new(3,3)
    assert_equal board.height, 3
    assert_equal board.width, 3
  end

  def test_board_can_get_a_coordinate
    board = Board.new(3,3)

    assert_equal '_', board.get('a1')
  end

  def test_internal_board_array_dimensions
    actual = Board.new(4,5)
    assert_equal 4, actual[0].size
    assert_equal 5, actual.size
  end

  def test_board_is_set_correctly
    actual = Board.new(5,6)

    assert_equal '_', actual[0][0]
    assert_equal '_', actual[1][1]
    assert_equal '_', actual[2][2]
    assert_equal '_', actual[3][3]
    assert_equal '_', actual[4][4]

    assert_equal ' ', actual[5][0]
    assert_equal ' ', actual[5][2]
    assert_equal ' ', actual[5][4]
  end
end
