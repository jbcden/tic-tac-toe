class Player
  attr_reader :symbol
  def initialize(symbol)
    @symbol = symbol
  end

  def make_move(board, coordinate)
    tile = BoardMapper.map_string(board, coordinate)
    tile.mark(symbol)
  end

  def human?
    true
  end
end
