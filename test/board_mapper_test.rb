require_relative './test_helper'
require 'board'
require 'board_mapper'

class BoardMapperTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_coordinate_strings_are_mapped_correctly
    expected = BoardMapper::Coordinate.new(0,0)
    actual = BoardMapper.map_string(@board, "a1")

    assert_equal expected, actual
  end

  def test_it_throws_an_error_for_invalid_column
    assert_raises(BoardMapper::InvalidCoordinateError) {
      BoardMapper.map_string(@board, "a4")
    }
  end

  def test_it_throws_an_error_for_invalid_row
    assert_raises(BoardMapper::InvalidCoordinateError) {
      BoardMapper.map_string(@board, "d3")
    }
  end

  def test_coordinates_can_be_mapped_into_strings
    actual = BoardMapper.map_coordinate(2,2)
    actual2 = BoardMapper.map_coordinate(6, 7)

    assert_equal "c3", actual
    assert_equal "g8", actual2
  end
end
