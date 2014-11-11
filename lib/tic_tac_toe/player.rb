class Player
  class InvalidCharacterError < StandardError
    def initialize(msg='Only "x" and "o" are valid character choices.')
      super
    end
  end
  attr_reader :symbol
  def initialize(symbol)
    if symbol == "x" || symbol == "o"
      @symbol = symbol
    else
      raise InvalidCharacterError
    end
  end

  def make_move(board, coordinate)
    tile = BoardMapper.map_string(board, coordinate)
    tile.mark(symbol)
  end

  def human?
    true
  end
end
