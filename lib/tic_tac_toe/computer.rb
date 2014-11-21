class Computer
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def calculate_best_move(board, game)
    unless new_board?(game.board)
      mini_max(game, symbol, 0)
      BoardMapper.map_coordinate(@move.xval, @move.yval)
    else
      tile = corners(board).sample
      BoardMapper.map_coordinate(tile.xval, tile.yval)
    end
  end

  def make_move(board, coordinate)
    tile = BoardMapper.map_string(board, coordinate)
    tile.mark(symbol)
  end

  def mini_max(game, current_player, depth)
    return evaluate(game, depth) if game.end_state?
    scores = []
    moves = []
    depth += 1

    available_moves(game.board).each do |tile|
      new_state = get_new_state(tile, game, current_player)

      # I got this idea from the post mentioned in the README
      scores << mini_max(new_state, next_player(current_player), depth)
      moves << tile
    end
    return choose_move(current_player, scores, moves)
  end

  def available_moves(board)
    unmarked_tiles(board)
  end

  def human?
    false
  end

  private
  def new_board?(board)
    unmarked_tiles(board).size == (board.width*board.height)
  end

  def corners(board)
    corners = []

    corners << board.first[0]
    corners << board.first.last

    corners << board.last.first
    corners << board.last.last
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

  def get_new_state(tile, game, current_player)
    temp_board = game.board.dup

    temp_board[tile.xval][tile.yval].mark(current_player)

    GameState.new(temp_board, game.turn_num+1, current_player)
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
