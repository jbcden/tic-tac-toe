require_relative './test_helper'
require 'tile'

class TileTest < MiniTest::Test
  def test_it_has_a_character
    actual = Tile.new('|')
    assert_equal '|', actual.symbol
  end

  def test_it_initially_is_marked
    actual = Tile.new('|')
    assert_equal false, actual.marked?
  end
end
