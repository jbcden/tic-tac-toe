require 'tile'

class Board
  extend Forwardable
  attr_reader :width, :height, :board
  def initialize(width, height)
    @width = width
    @height = height
    @board = Array.new(height)

    init_board_array
    init_board
  end

  def display
    DisplayBoard.call(board)
  end

  def_delegators :@board, :[], :[]=, :each, :first, :size
  private
  # def board_width
  #   width + (width-1)
  # end

  def init_board_array
    board.each_with_index do |row, index|
      board[index] = Array.new(width)
    end
  end

  def init_board
    board.each_with_index do |row, rownum|
      row.each_with_index do |column, index|
        set_rows(row, rownum, index)
      end
    end
  end

  def set_rows(row, rownum, index)
    if rownum != board.size - 1
      set_tile(row, index, '_', '|')
    else
      set_tile(row, index, ' ', '|')
    end
  end

  def set_tile(row, index, even_char, odd_char)
    row[index] = Tile.new(even_char)
    # if index.even?
    #   row[index] = Tile.new(even_char)
    # else
    #   row[index] = Tile.new(odd_char)
    # end
  end
end
