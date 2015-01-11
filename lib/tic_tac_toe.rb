require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/computer'
require_relative 'tic_tac_toe/display_board'
require_relative 'tic_tac_toe/player'
require_relative 'tic_tac_toe/game_io'
require_relative 'tic_tac_toe/configuration'
require_relative 'tic_tac_toe/turn'

class TicTacToe
  attr_reader :board, :turn_num, :players, :computer, :player, :game

  def self.start
    trap('INT') do
      puts 'exiting!'
      exit!
    end
    config = Configuration.new(Board.new(3,3), GameIO.new)
    turn = Turn.new(config, GameIO.new).start
  end

  # def initialize
  #   @board = Board.new(3,3)
  #   @io = GameIO.new
  #   @turn_num = 0
  #   @players = []
  # end

  # def play
  #   trap('INT') do
  #     puts 'exiting!'
  #     exit!
  #   end
  #   choose_human
  #   set_players_order
  #   game_loop
  # end


  # def choose_human
  #   error = ""
  #   while 1
  #     begin
  #       @io.choose_a_character_message
  #       human_symbol = @io.input
  #       @player = Player.new(human_symbol)
  #       break
  #     rescue Player::InvalidCharacterError => e
  #       @io.set_error(e.message)
  #       retry
  #     end
  #   end
  #   @computer = Computer.new(choose_computer(human_symbol))
  # end

  # def set_players_order
  #   @players << @player
  #   @players << @computer
  #   @players.shuffle!
  # end
  #
  # def game_loop
  #   while !@board.end_state?
  #     @io.print_board(@board)
  #
  #     current_player = @players[@turn_num % 2]
  #
  #     take_turn(current_player)
  #
  #     @turn_num += 1
  #   end
  #
  #   @io.print_board(@board)
  #
  #   @io.announce_winner(@board.end_state?)
  # end

  private

  # def take_turn(current_player)
  #   if current_player.human?
  #     human_move(current_player)
  #   else
  #     move = current_player.calculate_best_move(@board)
  #     computer.make_move(@board, move)
  #   end
  # end
  #
  # def human_move(current_player)
  #   error = ""
  #   while 1
  #     begin
  #       @io.print_board(@board)
  #       @io.prompt_turn
  #
  #       move = @io.input
  #       current_player.make_move(@board, move)
  #       break
  #     rescue Board::InvalidCoordinateError => e
  #        @io.set_error(e.message)
  #     rescue Board::InvalidActionError => e
  #       @io.set_error(e.message)
  #     end
  #   end
  # end
  #
  # def choose_computer(human)
  #   if human == "x"
  #     return "o"
  #   else
  #     return "x"
  #   end
  # end
end
