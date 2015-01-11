require 'game_io'
class GameIOTest < MiniTest::Test
  def setup
    @input = StringIO.new
    @output = StringIO.new
  end

  def test_can_print_a_message_with_a_clear_screen_signal
    io = GameIO.new(@input, @output)
    io.output("I am a message")

    assert_equal "\ecI am a message\n", @output.string
  end

  def test_can_print_a_message_without_a_clear_screen_signal
    io = GameIO.new(@input, @output)
    io.output("I am a message", false)

    assert_equal "I am a message\n", @output.string
  end

  def test_can_accept_input
    input = StringIO.new("x")
    io = GameIO.new(input, @output)
    char = io.input

    assert_equal "x", char
  end
end
