class Tile
  attr_reader :symbol
  attr_writer :mval

  def initialize(symbol)
    @symbol = symbol
  end

  def mval
    @mval ||= 0
  end

  def marked?
    @marked ||= false
  end
end
