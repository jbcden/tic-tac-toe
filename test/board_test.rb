require_relative './test_helper'
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

  def test_will_end_when_a_row_win_condition_is_met
    board = Board.new(3,3)

    board.mark("b1", "x")
    board.mark("b2", "x")
    board.mark("b3", "x")

    assert_equal "x", board.end_state?
  end

  def test_will_end_when_a_column_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a3", "x")
    board.mark("b3", "x")
    board.mark("c3", "x")

    assert_equal "x", board.end_state?
  end

  def test_will_end_when_a_left_diagonal_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a1", "x")
    board.mark("b2", "x")
    board.mark("c3", "x")

    assert_equal "x", board.end_state?
  end

  def test_will_end_when_a_right_diagonal_win_condition_is_met
    board = Board.new(3,3)

    board.mark("a3", "x")
    board.mark("b2", "x")
    board.mark("c1", "x")

    assert_equal "x", board.end_state?
  end

  def test_cat_is_winner_when_board_is_full
    board = Board.new(3,3)
    marked_squares = {
      a1: "o", a2: "o", a3: "x",
      b1: "x", b2: "x", b3: "o",
      c1: "o", c2: "x", c3: "o"
    }

    board.board = marked_squares

    assert_equal "cat", board.end_state?
  end

  def test_can_list_available_spaces
    board = Board.new(3,3)
    marked_squares = {
      :a1 => EMPTY_SPACE, :a2 => "x", :a3 => EMPTY_SPACE,
      :b1 => EMPTY_SPACE, :b2 => EMPTY_SPACE, :b3 => "x",
      :c1 => EMPTY_SPACE, :c2 => "x", :c3 => EMPTY_SPACE
    }

    board.board = marked_squares

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
    board = Board.new(3,3)
    marked_squares = {
      a1: "o", a2: "o", a3: "x",
      b1: "x", b2: "x", b3: "o",
      c1: "o", c2: "x", c3: "o"
    }

    board.board = marked_squares
    board_array = [["o", "o", "x"],
                   ["x", "x", "o"],
                   ["o", "x", "o"]]

    assert_equal(board.get_rows, board_array)
  end

  def test_can_list_columns_as_2d_array
    board = Board.new(3,3)
    marked_squares = {
      a1: "o", a2: "o", a3: "x",
      b1: "x", b2: "x", b3: "o",
      c1: "o", c2: "x", c3: "o"
    }

    board.board = marked_squares
    board_array = [["o", "x", "o"],
                   ["o", "x", "x"],
                   ["x", "o", "o"]]

    assert_equal(board.get_columns, board_array)
  end

  def test_can_list_diagonals_from_left
    board = Board.new(3,3)
    marked_squares = {
      a1: "o", a2: "o", a3: "x",
      b1: "x", b2: "x", b3: "o",
      c1: "o", c2: "x", c3: "o"
    }

    board.board = marked_squares
    board_array = ["x", "x", "o"]

    assert_equal(board.get_left_diagonal, board_array)
  end

  def test_can_list_diagonals_from_right
    board = Board.new(3,3)
    marked_squares = {
      a1: "o", a2: "o", a3: "x",
      b1: "x", b2: "x", b3: "o",
      c1: "o", c2: "x", c3: "o"
    }

    board.board = marked_squares
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
    assert_raises(Board::InvalidCoordinateError) {
      board.mark("d1", "x")
    }
  end

  def test_it_throws_an_error_when_given_invalid_coordinate_column
    board = Board.new(3,3)
    assert_raises(Board::InvalidCoordinateError) {
      board.mark("b4", "x")
    }
  end
end
