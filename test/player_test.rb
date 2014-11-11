require 'player'

class PlayerTest < MiniTest::Test
  def test_a_player_has_a_symbol
    player = Player.new("x")

    assert_equal "x", player.symbol
  end

  def test_a_player_has_a_turn_and_can_pick_a_move
    board = Board.new(3,3)
    player = Player.new("x")

    assert_equal false, board[0][1].marked?

    player.make_move(board, "a2")
    assert_equal true, board[0][1].marked?
    assert_equal player.symbol, board[0][1].symbol
  end
end
