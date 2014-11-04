class WinChecker
  def self.end_state?(board, num_turns)
    if num_turns >= min_turns
      row_win(board) || column_win(board) || diagonal_win(board)
    else
      false
    end
  end

    private
    def self.winner(xcount, ocount, board, method)
      win_num = board.public_method(method.to_sym).call

      if xcount == win_num
       "x"
      elsif ocount == win_num
        "o"
      else
        false
      end
    end

    def self.right_diagonal(board)
      xcount = 0
      ocount = 0
      col_num = board.width - 1

      board.each do |row|
        xcount += 1 if row[col_num].symbol == "x"
        ocount += 1 if row[col_num].symbol == "o"
        col_num -= 1
      end
      return winner(xcount, ocount, board, "height")
    end

    def self.left_diagonal(board)
      xcount = 0
      ocount = 0
      col_num = 0

      board.each do |row|
        xcount += 1 if row[col_num].symbol == "x"
        ocount += 1 if row[col_num].symbol == "o"
        col_num += 1
      end
      return winner(xcount, ocount, board, "height")
    end

    def self.diagonal_win(board)
      left_diagonal(board) ||
      right_diagonal(board)
    end

    def self.column_win(board)
      xcount = 0
      ocount = 0
      col_num = 0

      board.width.times do
        board.each do |row|
          xcount += 1 if row[col_num].symbol == "x"
          ocount += 1 if row[col_num].symbol == "o"
        end
        if w = winner(xcount, ocount, board, "height")
          return w
        end
        xcount = 0
        ocount = 0
        col_num += 1
      end
      false
    end

    def self.row_win(board)
      xcount = 0
      ocount = 0
      board.each do |row|
        row.each do |col|
          xcount += 1 if col.symbol == "x"
          ocount += 1 if col.symbol == "o"
        end
        if w = winner(xcount, ocount, board, "height")
          return w
        end
        xcount = 0
        ocount = 0
      end
      false
    end

    def self.min_turns
      5
    end
end
