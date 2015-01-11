require_relative './test_helper'
require 'game_errors'
require 'board'

class BoardTest < MiniTest::Test
  EMPTY_SPACE = " "
  def test_board_takes_a_height_and_length
    board = Board.new(3,3)
    assert_equal board.height, 3
    assert_equal board.width, 3
  end

  def test_board_can_get_a_coordinate
    board = Board.new(3,3)

    assert_equal EMPTY_SPACE, board.get('a1')
  end

  def test_board_is_set_correctly
    actual = Board.new(5,6)

    assert_equal EMPTY_SPACE, actual.get("a1")
    assert_equal EMPTY_SPACE, actual.get("b2")
    assert_equal EMPTY_SPACE, actual.get("c3")
    assert_equal EMPTY_SPACE, actual.get("d4")
    assert_equal EMPTY_SPACE, actual.get("e5")

    assert_equal EMPTY_SPACE, actual.get("f1")
    assert_equal EMPTY_SPACE, actual.get("f3")
    assert_equal EMPTY_SPACE, actual.get("f5")
  end

  # def test_will_end_when_a_row_win_condition_is_met
  #   board = Board.new(3,3)
  #
  #   board.mark("b1", "x")
  #   board.mark("b2", "x")
  #   board.mark("b3", "x")
  #
  #   assert_equal "x", board.end_state?
  # end
  #
  # def test_will_end_when_a_column_win_condition_is_met
  #   board = Board.new(3,3)
  #
  #   board.mark("a3", "x")
  #   board.mark("b3", "x")
  #   board.mark("c3", "x")
  #
  #   assert_equal "x", board.end_state?
  # end
  #
  # def test_will_end_when_a_left_diagonal_win_condition_is_met
  #   board = Board.new(3,3)
  #
  #   board.mark("a1", "x")
  #   board.mark("b2", "x")
  #   board.mark("c3", "x")
  #
  #   assert_equal "x", board.end_state?
  # end
  #
  # def test_will_end_when_a_right_diagonal_win_condition_is_met
  #   board = Board.new(3,3)
  #
  #   board.mark("a3", "x")
  #   board.mark("b2", "x")
  #   board.mark("c1", "x")
  #
  #   assert_equal "x", board.end_state?
  # end
  #
  # def test_cat_is_winner_when_board_is_full
  #   board = Board.new(3,3)
  #
  #   board.mark("a1", "o")
  #   board.mark("a2", "o")
  #   board.mark("a3", "x")
  #   board.mark("b1", "x")
  #   board.mark("b2", "x")
  #   board.mark("b3", "o")
  #   board.mark("c1", "o")
  #   board.mark("c2", "x")
  #   board.mark("c3", "o")
  #
  #   assert_equal "cat", board.end_state?
  # end

  def test_can_list_available_spaces
    board = Board.new(3,3)

    board.mark("a1", EMPTY_SPACE)
    board.mark("a2", "x")
    board.mark("a3", EMPTY_SPACE)
    board.mark("b1", EMPTY_SPACE)
    board.mark("b2", EMPTY_SPACE)
    board.mark("b3", "x")
    board.mark("c1", EMPTY_SPACE)
    board.mark("c2", "x")
    board.mark("c3", EMPTY_SPACE)

    available_tiles = board.available_tiles

    refute_includes available_tiles, "a2"
    refute_includes available_tiles, "b3"
    refute_includes available_tiles, "c2"

    assert_includes available_tiles, "a1"
    assert_includes available_tiles, "a3"
    assert_includes available_tiles, "b1"
    assert_includes available_tiles, "b2"
    assert_includes available_tiles, "c1"
    assert_includes available_tiles, "c3"
  end

  def test_can_list_rows_as_2d_array
    skip
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

    board_array = [["o", "o", "x"],
                   ["x", "x", "o"],
                   ["o", "x", "o"]]

    assert_equal(board.get_rows, board_array)
  end

  def test_can_list_columns_as_2d_array
    skip
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

    board_array = [["o", "x", "o"],
                   ["o", "x", "x"],
                   ["x", "o", "o"]]

    assert_equal(board.get_columns, board_array)
  end

  def test_can_list_diagonals_from_left
    skip
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

    board_array = ["x", "x", "o"]

    assert_equal(board.get_left_diagonal, board_array)
  end

  def test_can_list_diagonals_from_right
    skip
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

    board_array = ["o", "x", "o"]

    assert_equal(board.get_right_diagonal, board_array)
  end

  def test_can_list_corners
    board = Board.new(3,3)
    corners = ["a1", "a3", "c1", "c3"]
    assert_equal corners, board.corners
  end

  def test_it_throws_an_error_when_given_invalid_coordinate_row
    board = Board.new(3,3)
    assert_raises(GameErrors::InvalidCoordinateError) {
      board.mark("d1", "x")
    }
  end

  def test_it_throws_an_error_when_given_invalid_coordinate_column
    board = Board.new(3,3)
    assert_raises(GameErrors::InvalidCoordinateError) {
      board.mark("b4", "x")
    }
  end
end
