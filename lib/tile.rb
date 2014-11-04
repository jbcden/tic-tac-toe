class Tile
  class InvalidActionError < StandardError
    def initialize(msg="You cannot modify this tile.")
      super
    end
  end
  attr_reader :symbol
  attr_writer :mval, :marked, :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def mval
    @mval ||= 0
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
