class WinChecker
  def self.call(board)
    @@board = board
    row_win? || column_win? || diagonal_win? || full_board?
  end

  private
  def self.full_board?
    if @@board.available_tiles.empty?
      "cat"
    else
      false
    end
  end

  def self.winner(xcount, ocount, method)
    win_num = @@board.public_method(method.to_sym).call

    if xcount == win_num
      "x"
    elsif ocount == win_num
      "o"
    else
      false
    end
  end

  def self.win?(xcount, ocount, method)
    if w = winner(xcount, ocount, method)
      return w
    end
    false
  end

  def self.right_diagonal
    xcount = sum(@@board.get_right_diagonal, "x")
    ocount = sum(@@board.get_right_diagonal, "o")
    win?(xcount, ocount, "height")
  end

  def self.left_diagonal
    xcount = sum(@@board.get_left_diagonal, "x")
    ocount = sum(@@board.get_left_diagonal, "o")
    win?(xcount, ocount, "height")
  end

  def self.diagonal_win?
    left_diagonal ||
        right_diagonal
  end

  def self.sum(chunk, symbol)
    chunk.select { |location|
      location == symbol
    }.size
  end

  def self.row_col_win?(row_or_column, predicate)
    row_or_column.each do |chunk|
      xcount = sum(chunk, "x")
      ocount = sum(chunk, "o")
      victor = win?(xcount, ocount, predicate)
      return victor if victor
    end
    false
  end

  def self.column_win?
    row_col_win?(@@board.get_columns, "height")
  end

  def self.row_win?
    row_col_win?(@@board.get_rows, "width")
  end
end
