class GameIO
  def initialize(input=STDIN, output=STDOUT)
    @input = input
    @output = output
    @error = nil
  end

  def choose_a_character_message
    clear_screen
    @output.print "Which player would you like to be? (\"x\" or \"o\") "
    print_error
  end

  def announce_winner(winner)
    @output.puts "The winner is: #{winner}"
  end

  def prompt_turn
    @output.print "Please choose a square to mark: "
    print_error
  end

  def print_board(board)
    clear_screen
    @output.puts DisplayBoard.call(board)
  end

  def set_error(error_message)
    @error = error_message
  end

  # may use this as a master input method
  def input
    @input.gets.chomp
  end

  # def choose_character
  #   @input.gets.chomp
  # end

  # def make_move
  #   @input.gets.chomp
  # end

  private
  def print_error
    return nil unless @error
    @output.print "\n#{@error} "
    reset_error
  end

  def clear_screen
    @output.print "\033c"
  end

  def reset_error
    @error = nil
  end
end
