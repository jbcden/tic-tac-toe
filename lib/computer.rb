class Computer

  def self.make_move(board, turn_num, symbol)
    @symbol = symbol
    game = initial_game_state(board, turn_num, symbol)
    mini_max(game, symbol, 0)
    @move
  end

  def self.mini_max(game, current_player, depth)
    return evaluate(game, depth) if game.end_state?
    scores = []
    moves = []
    depth += 1

    available_moves(game.board).each do |tile|
      new_state = get_new_state(tile, game, current_player)

      scores << mini_max(new_state, next_player(current_player), depth)
      moves << tile
    end
    return choose_move(current_player, scores, moves)
  end

  def self.available_moves(board)
    unmarked_tiles(board)
  end

  private
  def self.initial_game_state(board, turn_num, symbol)
    GameState.new(board, turn_num, symbol)
  end

  def self.choose_move(current_player, scores, moves)
    if current_player == symbol
      max_index = scores.each_with_index.max[1]
      @move = moves[max_index]
      return scores[max_index]
    else
      min_index = scores.each_with_index.min[1]
      @move = moves[min_index]
      return scores[min_index]
    end
  end

  def self.evaluate(game, depth)
    if game.end_state? == symbol
      return 1 - depth
    elsif game.end_state? == opponent
      return depth - 1
    else
      return 0
    end
  end

  def self.symbol
    @symbol
  end

  def self.get_new_state(tile, game, current_player)
    # copy board class and deep copy the inner board array
    # Marshal is necessary b/c board array does not contain
    # Plain Old Ruby Objects
    temp_board = game.board.dup
    board_array = Marshal.load(Marshal.dump(game.board.board))
    temp_board.board = board_array

    temp_board[tile.xval][tile.yval].mark(current_player)

    GameState.new(temp_board, game.turn_num+1, current_player)
  end

  def self.next_player(current_player)
    if current_player == "x"
      "o"
    else
      "x"
    end
  end

  def self.opponent
    next_player(symbol)
  end

  def self.unmarked_tiles(board)
    unmarked = []
    board.each do |row|
      row.each do |tile|
        unmarked << tile unless tile.marked?
      end
    end
    unmarked
  end
end
