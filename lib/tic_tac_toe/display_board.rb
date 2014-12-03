class DisplayBoard

  ROW_NAMES = [
                "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
                "n", "o", "p", "q", "r", "t", "u", "v", "w", "x", "y", "z"
              ]

  def self.call(board)
    str = ""
    row_num = 0
    str << print_column_numbers(board.first.size)

    board.each do |row|
      str << print_row(row, row_num)
      row_num += 1
    end
    str
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

  def self.print_row(row, row_num)
    str = ""
    str << ROW_NAMES[row_num] << " "
    row.each_with_index do |symbol, index|
      str << symbol
      str << "|" unless index == row.size-1
    end
    str << "\n"
    str
  end
end
