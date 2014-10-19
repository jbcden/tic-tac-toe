class Tile
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def marked?
    @marked ||= false
  end
end
