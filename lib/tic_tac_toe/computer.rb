class Computer
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  # remove game from being passed in.
  # it is redundant as it is re-initialized
  # in mini-max and does not serve any purpose in tic_tac_toe.rb
  def calculate_best_move(board)
    unless new_board?(board)
      mini_max(board, symbol, 0)
      @move
      # BoardMapper.map_coordinate(@move.x, @move.y)
    else
      tile = board.corners.sample
    end
  end

  def make_move(board, coordinate)
    board.mark(coordinate, symbol)
  end

  def mini_max(board, current_player, depth)
    return evaluate(board, depth) if board.end_state?
    scores = []
    moves = []
    depth += 1

    available_moves(board).each do |coord|
      new_board_state = get_new_state(coord, board, current_player)

      # I got this idea from the post mentioned in the README
      scores << mini_max(new_board_state, next_player(current_player), depth)
      moves << coord
    end
    return choose_move(current_player, scores, moves)
  end

  def available_moves(board)
    board.available_tiles
  end

  def human?
    false
  end

  private
  def new_board?(board)
    available_moves(board).size == (board.width*board.height)
  end

  def initial_game_state(board, turn_num, symbol)
    GameState.new(board, turn_num, symbol)
  end

  def choose_move(current_player, scores, moves)
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

  def evaluate(game, depth)
    if game.end_state? == symbol
      return 10 - depth
    elsif game.end_state? == opponent
      return depth - 10
    else
      return 0
    end
  end

  def get_new_state(coord, board, current_player)
    temp_board = board.dup

    temp_board.mark(coord, current_player)

    temp_board
  end

  def next_player(current_player)
    if current_player == "x"
      "o"
    else
      "x"
    end
  end

  def opponent
    next_player(symbol)
  end

  def unmarked_tiles(board)
    unmarked = []
    board.each do |row|
      row.each do |tile|
        unmarked << tile unless tile.marked?
      end
    end
    unmarked
  end
end
