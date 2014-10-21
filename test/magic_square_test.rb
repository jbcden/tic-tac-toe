require_relative './test_helper'
require 'magic_square'

class MagicSqaureTest < MiniTest::Test
  def setup
    @valid_board = Board.new(3,3)
    @invalid_board = Board.new(2,3)
    @invalid_square = Board.new(2,2)
  end

  def sum_row(board)
    count = 0
    board.board.first.each do |element|
      count += element.mval
    end
    count
  end
  def sum_column(board)
    count = 0
    row = 0
    while row < board.height
      count += board.board[row][2].mval # this will only work for boards 3x3 and up
      row += 1
    end
    count
  end
  def sum_diagonals(board)
    count = 0
    row = 0
    col = 0

    while row < board.height
      count += board.board[row][col].mval

      row += 1
      col += 1
    end
    count
  end

  def test_throws_exception_when_not_given_a_square
    assert_raises(MagicSquare::InvalidBoardError) {
      MagicSquare.generate(@invalid_board)
    }
  end
  def test_throws_exception_if_dimensions_of_board_not_odd
    assert_raises(MagicSquare::DimensionError) {
      MagicSquare.generate(@invalid_square)
    }
  end

  def test_creates_rows_with_correct_sum
    MagicSquare.generate(@valid_board)
    assert_equal 15, sum_row(@valid_board)
  end
  def test_creates_columns_with_correct_sum
    MagicSquare.generate(@valid_board)
    assert_equal 15, sum_column(@valid_board)
  end
  def test_creates_diagonals_with_correct_sum
    MagicSquare.generate(@valid_board)
    assert_equal 15, sum_diagonals(@valid_board)
  end
end
