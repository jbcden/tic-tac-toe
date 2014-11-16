class GameState
  attr_reader :board, :turn_num, :current_player
  def initialize(board, turn_num, current_player)
    @board = board
    @turn_num = turn_num
    @player = current_player
  end

  def end_state?
    if turn_num >= min_turns
      row_win(board) || column_win(board) || diagonal_win(board) || full_board(board)
    else
      false
    end
  end

    private
    def full_board(board)
      marked = []
      board.each do |row|
        row.each do |tile|
          marked << tile if tile.marked?
        end
      end
      if marked.size == (board.width*board.height)
        "cat"
      else
        false
      end
    end

    def winner(xcount, ocount, board, method)
      win_num = board.public_method(method.to_sym).call
      cat = (board.width*board.height)/2 + 1

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

    def diagonal_iterator(board, col_num, iterator)
      xcount = 0
      ocount = 0

      board.each do |row|
        xcount += 1 if row[col_num].symbol == "x"
        ocount += 1 if row[col_num].symbol == "o"
        col_num += iterator
      end
      winner(xcount, ocount, board, "height")
    end

    def right_diagonal(board)
      diagonal_iterator(board, board.width - 1, -1)
    end

    def left_diagonal(board)
      diagonal_iterator(board, 0, 1)
    end

    def diagonal_win(board)
      left_diagonal(board) ||
      right_diagonal(board)
    end

    def column_win(board)
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

    def row_win(board)
      xcount = 0
      ocount = 0
      board.each do |row|
        row.each do |col|
          xcount += 1 if col.symbol == "x"
          ocount += 1 if col.symbol == "o"
        end
        if w = winner(xcount, ocount, board, "width")
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
