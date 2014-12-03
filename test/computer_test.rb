require_relative './test_helper'
require 'computer'
require 'board'
require 'game_state'

class ComputerTest < MiniTest::Test
  def setup
    @board = Board.new(3,3)
  end

  def test_can_get_list_of_available_moves
    computer = Computer.new("x")

    # @board[0][1].mark("x")
    @board.mark("a2", "x")
    # @board[1][2].mark("x")
    @board.mark("b3", "x")
    # @board[2][1].mark("x")
    @board.mark("c2", "x")

    available_moves = computer.available_moves(@board)

    # refute_includes available_moves, @board[0][1]
    refute_includes available_moves, BoardMapper::Coordinate.new(0,1)
    # refute_includes available_moves, @board[1][2]
    refute_includes available_moves, BoardMapper::Coordinate.new(1,2)
    # refute_includes available_moves, @board[2][1]
    refute_includes available_moves, BoardMapper::Coordinate.new(2,1)

    # assert_includes available_moves, @board[0][0]
    assert_includes available_moves, BoardMapper::Coordinate.new(0,0)
    # assert_includes available_moves, @board[0][2]
    assert_includes available_moves, BoardMapper::Coordinate.new(0,2)
    # assert_includes available_moves, @board[1][0]
    assert_includes available_moves, BoardMapper::Coordinate.new(1,0)
    # assert_includes available_moves, @board[1][1]
    assert_includes available_moves, BoardMapper::Coordinate.new(1,1)
    # assert_includes available_moves, @board[2][0]
    assert_includes available_moves, BoardMapper::Coordinate.new(2,0)
    # assert_includes available_moves, @board[2][2]
    assert_includes available_moves, BoardMapper::Coordinate.new(2,2)
  end

  def test_select_winning_move
    computer = Computer.new("x")

    # @board[0][0].mark("o")
    @board.mark("a1", "o")
    # @board[2][1].mark("o")
    @board.mark("c2", "o")
    # @board[2][2].mark("o")
    @board.mark("c3", "o")

    # @board[0][2].mark("x")
    @board.mark("a3", "x")
    # @board[1][0].mark("x")
    @board.mark("b1", "x")
    # @board[2][0].mark("x")
    @board.mark("c1", "x")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)

    assert_equal "b2", move
  end

  def test_select_winning_move_depth
    computer = Computer.new("o")

    # @board[2][0].mark("x")
    @board.mark("c1", "x")
    # @board[2][1].mark("x")
    @board.mark("c2", "x")

    # @board[0][1].mark("o")
    @board.mark("a2", "o")
    # @board[1][2].mark("o")
    @board.mark("b3", "o")
    # @board[2][2].mark("o")
    @board.mark("c3", "o")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)

    assert_equal "a3", move
  end

  def test_computer_marks_best_move
    computer = Computer.new("o")

    # @board[2][0].mark("x")
    @board.mark("c1", "x")
    # @board[2][1].mark("x")
    @board.mark("c2", "x")

    # @board[0][1].mark("o")
    @board.mark("a2", "o")
    # @board[1][2].mark("o")
    @board.mark("b3", "o")
    # @board[2][2].mark("o")
    @board.mark("c3", "o")

    game = GameState.new(@board, 7, computer.symbol)

    move = computer.calculate_best_move(@board, game)
    computer.make_move(@board, move)

    tile = BoardMapper.map_string(@board, move)

    coord = BoardMapper.map_coordinate(tile.x, tile.y)
    assert_equal true, @board.marked?(coord)
    assert_equal "o", @board.get(coord)
  end
end
