class DisplayBoard

  def self.call(board)
    str = ""
    board.each do |row|
      str << print_row(row)
    end
    str
  end

  private
  def self.print_row(row)
    str = ""
    row.each do |column|
      str << column.symbol
    end
    str << "\n"
    str
  end
end
