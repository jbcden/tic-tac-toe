class Tile
  class InvalidActionError < StandardError
    def initialize(msg="This tile has already been marked")
      super
    end
  end
  attr_reader :symbol, :xval, :yval
  attr_writer :marked, :symbol

  def initialize(symbol, xval, yval)
    @symbol = symbol
    @xval = xval
    @yval = yval
  end

  def marked?
    @marked ||= false
  end

  def mark(new_symbol)
    if markable?
      @symbol = new_symbol
      @marked = true
    else
      raise InvalidActionError
    end
  end

  private
  def markable?
    # we need to accept the ' ' because the symbol for the bottom left and right
    # corners of the board is ' '. Must remember to look at this again later.
    @symbol == '_' || @symbol == ' '
  end
end
