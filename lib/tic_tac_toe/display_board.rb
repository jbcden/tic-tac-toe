class DisplayBoard

  ROW_NAMES = [
                "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "t", "u", "v", "w", "x", "y", "z"
              ]

  def self.call(board)
    @@board = board
    str = ""
    str << print_column_numbers(@@board.width)
    print_rows(str)
  end

  private
  def self.print_column_numbers(row_size)
    str = "  "
    col = 1
    count = row_size

    row_size.times do
      str << col.to_s << " "
      col += 1
    end
    str << "\n"
    str
  end

  def self.print_row(row_num)
    str = ""
    row = ROW_NAMES[row_num]
    str << row << " "
    str << print_row_columns(row, row_num)

    str << "\n"
    str
  end

  def self.print_row_columns(row, row_num)
    str = ""
    x_coord = 1
    @@board.width.times do
      coord = get_coord(row, x_coord)
      symbol = @@board.get(coord)

      empty_symbol?(symbol, row_num, @@board.height) ? str << "_" : str << symbol

      str << "|" unless x_coord == @@board.width
      x_coord += 1
    end
    str
  end

  def self.get_coord(row, x_coord)
    "" << row << x_coord.to_s
  end

  def self.print_rows(str)
    row_num = 0
    @@board.height.times do
      str << print_row(row_num)
      row_num += 1
    end
    str
  end

  def self.empty_symbol?(symbol, row_num, board_height)
    # symbols are initialized as " "
    symbol.strip.empty? && row_num != board_height - 1
 end
end
