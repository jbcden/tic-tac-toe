require_relative './test_helper'
require 'game_state'

class GameStateTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end
end
