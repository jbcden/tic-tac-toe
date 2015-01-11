require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/computer'
require_relative 'tic_tac_toe/display_board'
require_relative 'tic_tac_toe/player'
require_relative 'tic_tac_toe/game_io'
require_relative 'tic_tac_toe/configuration'
require_relative 'tic_tac_toe/turn'
require_relative 'tic_tac_toe/messages'

class TicTacToe

  def self.start
    trap('INT') do
      puts 'exiting!'
      exit!
    end
    config = Configuration.new(Board.new(3,3), GameIO.new)
    turn = Turn.new(config, GameIO.new).start
  end

end
