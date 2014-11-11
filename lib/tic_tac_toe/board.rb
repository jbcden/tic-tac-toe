require_relative 'tile'
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

  def display
    DisplayBoard.call(board)
  end

  def_delegators :@board, :[], :[]=, :each, :first, :size, :last
  private

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
      set_tile(row, rownum, index, '_')
    else
      set_tile(row, rownum, index, ' ')
    end
  end

  def set_tile(row, rownum, index, tile_char)
    row[index] = Tile.new(tile_char, rownum, index)
  end
end
