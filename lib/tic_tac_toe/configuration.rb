class Configuration
  attr_reader :board, :turn_num
  def initialize(board, io)
    @board = board
    @io = io
    @turn_num = 0
    @players = []
    initialize_players.shuffle!
  end

  def current_player
    @players[@turn_num%2]
  end

  def next_turn
    @turn_num += 1
  end

  def end_state?
    @board.end_state?
  end

  private
  def initialize_players
    @io.choose_a_character_message
    human = @io.input
    opposing_symbol = opposite_of(human)
    begin
      @players << Player.new(human)
    rescue Player::InvalidCharacterError => e
      @io.set_error(e.message)
      initialize_players
    end
    @players << Computer.new(opposing_symbol)
  end

  def opposite_of(human)
    return "x" if human == "o"
    "o"
  end
end
