require_relative './test_helper'
require 'board'
require 'display_board'

class DisplayBoardTest < MiniTest::Test
  def test_board_display
    actual = Board.new(3,3).display
    result = <<'BOARD'
  1 2 3 
a _|_|_
b _|_|_
c  | | 
BOARD

    assert_equal result, actual
  end
end
