class Computer

  def self.score(board)
    {}
  end

  def self.available_moves(board)
    unmarked_tiles(board)
  end

  private
  # this will be modified to be dynamic once I hook it into
  # the actual game's framework
  def self.symbol
    "x"
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
