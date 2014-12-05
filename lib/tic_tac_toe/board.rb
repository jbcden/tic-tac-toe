require_relative 'tile'
require_relative 'board_mapper'
require 'forwardable'

class Board
  extend Forwardable
  attr_reader :width, :height, :board
  attr_writer :board
  def initialize(width, height)
    @width = width
    @height = height
    @board = Array.new(height)

    init_board_array
    init_board
  end

  def end_state?
    row_win || column_win || diagonal_win || full_board
  end

  def available_tiles
    unmarked = []
    board.each_with_index  do |row, rownum|
      row.each_with_index do |sym, index|
        if sym == '_' || sym == ' '
          unmarked << BoardMapper::Coordinate.new(rownum, index)
        end
      end
    end
    unmarked
  end

  def mark(coordinate, symbol)
    location = BoardMapper.map_string(self, coordinate)
    set_location_symbol(location, symbol)
  end

  def marked?(coordinate)
    sym = get_location_symbol(BoardMapper.map_string(self, coordinate))

    sym != '_' and sym != ' '
  end

  def get(coordinate)
    location = BoardMapper.map_string(self, coordinate)
    get_location_symbol(location)
  end

  def display
    DisplayBoard.call(board)
  end

  def dup
    # copy board class and deep copy the inner board array
    # Marshal is necessary b/c board array does not contain
    # Plain Old Ruby Objects
    super.tap do
      temp_board = Marshal.load(Marshal.dump(board))
      self.board = temp_board
    end
  end

  def_delegators :@board, :[], :[]=, :each, :first, :size, :last
  private

  def set_location_symbol(location, symbol)
    board[location.x][location.y] = symbol
  end

  def get_location_symbol(location)
    board[location.x][location.y]
  end

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
