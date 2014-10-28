require_relative './test_helper'
require 'board'
require 'board_mapper'

class BoardMapperTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_coordinates_are_mapped_correctly
    expected = @board[0][0]
    actual = BoardMapper.map(@board, "a1")

    assert_equal expected, actual
  end

  def test_it_throws_an_error_for_invalid_column
    assert_raises(BoardMapper::InvalidCoordinateError) {
      BoardMapper.map(@board, "a4")
    }
  end

  def test_it_throws_an_error_for_invalid_row
    assert_raises(BoardMapper::InvalidCoordinateError) {
      BoardMapper.map(@board, "d3")
    }
  end
end
