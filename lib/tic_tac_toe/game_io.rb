class GameIO
  def initialize(input=STDIN, output=STDOUT)
    @input = input
    @output = output
    @error = nil
  end

  def output(message, clear=true)
    clear_screen if clear
    @output.puts message
    print_error
  end

  # may use this as a master input method
  def input
    @input.gets.chomp
  end

  def set_error(error_message)
    @error = error_message
  end

  private
  def print_error
    return nil unless @error
    @output.puts "#{@error} "
    reset_error
  end

  def clear_screen
    @output.print "\033c"
  end

  def reset_error
    @error = nil
  end
end
