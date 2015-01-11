class Turn
  def initialize(config, io)
    @config = config
    @io = io
  end

  def start
    while !@config.end_state?
      @io.print_board(board)

      take_turn(@config.current_player)

      @config.next_turn
    end

    @io.print_board(board)

    @io.announce_winner(board.end_state?)
  end

  private
  def board
    @config.board
  end

  def take_turn(current_player)
    if current_player.human?
      human_move(current_player)
    else
      move = current_player.calculate_best_move(board)
      current_player.make_move(board, move)
    end
  end

  def human_move(current_player)
    error = ""
    while 1
      begin
        @io.print_board(board)
        @io.prompt_turn

        move = @io.input
        current_player.make_move(board, move)
        break
      rescue Board::InvalidCoordinateError => e
         @io.set_error(e.message)
      rescue Board::InvalidActionError => e
        @io.set_error(e.message)
      end
    end
  end
end
