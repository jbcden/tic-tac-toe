require 'game_io'
class GameIOTest < MiniTest::Test
  def setup
    @input = StringIO.new
    @output = StringIO.new
    @test_board = Board.new(3,3)
  end

  #weird character in expected is because of the clear_screen...
  def test_can_print_a_request_to_choose_character
    io = GameIO.new(@input, @output)
    io.choose_a_character_message

    assert_equal "\ecWhich player would you like to be? (\"x\" or \"o\") ", @output.string
  end

  def test_can_announce_the_winner
    io = GameIO.new(@input, @output)
    io.announce_winner("x")

    assert_equal "The winner is: x\n", @output.string
  end

  def test_turn_message
    io = GameIO.new(@input, @output)
    io.prompt_turn

    assert_equal "Please choose a square to mark: ", @output.string
  end

  # def test_does_not_print_error_if_not_present
  #   io = GameIO.new(@input, @output)
  #   io.print_error
  #
  #   assert_equal "", @output.string
  # end
  #
  # def test_prints_error_when_present
  #   io = GameIO.new(@input, @output)
  #   io.set_error("This is an error")
  #   io.print_error
  #
  #   assert_equal "\nThis is an error: ", @output.string
  # end

  def test_can_accept_input
    input = StringIO.new("x")
    io = GameIO.new(input, @output)
    char = io.input

    assert_equal "x", char
  end
end
