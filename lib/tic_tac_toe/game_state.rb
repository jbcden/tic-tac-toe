class GameState
  attr_reader :board, :turn_num, :current_player
  def initialize(board, turn_num, current_player)
    @board = board
    @turn_num = turn_num
    @player = current_player
  end
end
