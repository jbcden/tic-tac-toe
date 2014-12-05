require_relative 'tile'
require_relative 'board_mapper'
require 'forwardable'

class Board
  extend Forwardable
  BOARD_MAPPINGS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
                    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  attr_reader :width, :height, :board
  attr_writer :board
  def initialize(width, height)
    @width = width
    @height = height
    @board = Hash.new

    init_board
  end

  def end_state?
    row_win || column_win || diagonal_win || full_board
  end

  def available_tiles
    unmarked = []
    unmarked = board.select {|coord, space| marked?(coord)}.
                     map {|coord, space| coord.to_s}
  end

  def mark(coordinate, symbol)
    set_location_symbol(coordinate, symbol)
  end

  def marked?(coordinate)
    board[coordinate].empty?
  end

  def get(coordinate)
    get_location_symbol(coordinate)
  end

  def display
    DisplayBoard.call(board)
  end

  def_delegators :@board, :[], :[]=, :each, :first, :size, :last, :merge!
  private

  def set_location_symbol(location, symbol)
    board[location.to_sym] = symbol
  end

  def get_location_symbol(location)
    board[location.to_sym]
  end

  def init_board
    row_index = 0
    column_index = 1
    @height.times do
      @width.times do
        key = ""
        key << BOARD_MAPPINGS[row_index] << column_index.to_s
        @board[key.to_sym] = ""
        column_index += 1
      end
      row_index += 1
      column_index = 1
    end

  end

  def set_rows(row, rownum, index)
    if rownum != board.size - 1
      # set_tile(row, rownum, index, '_')
      row[index] = '_'
    else
      # set_tile(row, rownum, index, ' ')
      row[index] = ' '
    end
  end

  def set_tile(row, rownum, index, tile_char)
    row[index] = Tile.new(tile_char, rownum, index)
  end

  def full_board
    if available_tiles.size == (width*height)
      "cat"
    else
      false
    end
  end

  def winner(xcount, ocount, method)
    win_num = self.public_method(method.to_sym).call
    cat = (width*height)/2 + 1

    if xcount == win_num
      "x"
    elsif ocount == win_num
      "o"
    elsif ocount == cat || xcount == cat
      "cat"
    else
      false
    end
  end

  def diagonal_iterator(col_num, iterator)
    xcount = 0
    ocount = 0

    board.each do |row|
      xcount += 1 if row[col_num] == "x"
      ocount += 1 if row[col_num] == "o"
      col_num += iterator
    end
    winner(xcount, ocount, "height")
  end

  def right_diagonal
    diagonal_iterator(width - 1, -1)
  end

  def left_diagonal
    diagonal_iterator(0, 1)
  end

  def diagonal_win
    left_diagonal ||
        right_diagonal
  end

  def column_win
    xcount = 0
    ocount = 0
    col_num = 0

    width.times do
      board.each do |row|
        xcount += 1 if row[col_num] == "x"
        ocount += 1 if row[col_num] == "o"
      end
      if w = winner(xcount, ocount, "height")
        return w
      end
      xcount = 0
      ocount = 0
      col_num += 1
    end
    false
  end

  def row_win
    xcount = 0
    ocount = 0
    board.each do |row|
      row.each do |col|
        xcount += 1 if col == "x"
        ocount += 1 if col == "o"
      end
      if w = winner(xcount, ocount, "width")
        return w
      end
      xcount = 0
      ocount = 0
    end
    false
  end

  def min_turns
    5
  end
end
