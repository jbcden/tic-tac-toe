class Player
  attr_reader :symbol
  def initialize(symbol)
    if symbol == "x" || symbol == "o"
      @symbol = symbol
    else
      raise GameErrors::InvalidCharacterError
    end
  end

  def make_move(board, coordinate)
    board.mark(coordinate, symbol)
  end

  def human?
    true
  end
end
