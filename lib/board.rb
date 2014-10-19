require 'tile'

class Board
  attr_reader :width, :height, :board
  def initialize(width, height)
    @width = width
    @height = height
    @board = Array.new(height)

    init_board_array
    init_board
  end

  def display
    str = ""
    board.each do |row|
      str << print_row(row)
    end
    str
  end

  private
  def board_width
    width + (width-1)
  end

  def init_board_array
    board.each_with_index do |row, index|
      board[index] = Array.new(board_width)
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
      set_tile(row, index)
    else
      set_tile_final_row(row, index)
    end
  end

  def set_tile(row, index)
    if index.even?
      row[index] = Tile.new('_')
    else
      row[index] = Tile.new('|')
    end
  end

  def set_tile_final_row(row, index)
    if index.even?
      row[index] = Tile.new(' ')
    else
      row[index] = Tile.new('|')
    end
  end

  def print_row(row)
    str = ""
    row.each do |column|
      str << column.symbol
    end
    str << "\n"
    str
  end
end
