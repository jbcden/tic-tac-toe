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

  def test_can_mark_a_tile
    tile = Tile.new('_')
    tile.mark("x")

    assert_equal "x", tile.symbol
    refute_equal '_', tile.symbol
  end

  def test_marking_a_tile_marks_it
    tile = Tile.new('_')
    assert_equal false, tile.marked?

    tile.mark("x")
    assert_equal true, tile.marked?
  end

  def test_cannot_mark_pipe_tiles
    tile = Tile.new('|')

    assert_raises(Tile::InvalidActionError) {
      tile.mark("x")
    }
  end
end
