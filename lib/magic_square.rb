#
# The algorithm being used for this program is taken from
# http://introcs.cs.princeton.edu/java/14array/MagicSquare.java.html
#
class MagicSquare
  class InvalidBoardError < StandardError
    def initialize(msg="The board must be a sqaure.")
      super
    end
  end
  class DimensionError < StandardError
    def initialize(msg="The board's dimensions must be of odd arity.")
      super
    end
  end

  def self.generate(board)
    raise InvalidBoardError unless is_square?(board)
    raise DimensionError unless is_odd?(board)
    n = board.height
    count = 2

    row = n-1
    col = n/2
    board[row][col].mval = 1

    while count <= n*n
      if (board[(row + 1) % n][(col + 1) % n].mval == 0)
        row = (row + 1) % n;
        col = (col + 1) % n;
      else
        row = (row - 1 + n) % n;
      end

      board[row][col].mval = count;
      count += 1
    end
  end

  private
  def self.is_square?(board)
    board.width == board.height
  end
  def self.is_odd?(board)
    board.width.odd? # we can check just one side since we know the board is square
  end
end
