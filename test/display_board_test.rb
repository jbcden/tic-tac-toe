require_relative './test_helper'
require 'board'
require 'display_board'

class DisplayBoardTest < MiniTest::Test
  def test_board_display
    actual = Board.new(3,3).display
    result = <<'BOARD'
_|_|_
_|_|_
 | | 
BOARD

    assert_equal result, actual
  end
end
