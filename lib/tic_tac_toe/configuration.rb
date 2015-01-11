class Configuration
  attr_reader :board, :turn_num, :players
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
    @io.output(Messages.choose_a_character)
    human = @io.input
    opposing_symbol = opposite_of(human)
    begin
      player = Player.new(human)
      @players << player
      @players << Computer.new(opposing_symbol)
    rescue Player::InvalidCharacterError => e
      @io.set_error(e.message)
      initialize_players
    end
    @players
  end

  def opposite_of(human)
    return "x" if human == "o"
    "o"
  end
end
