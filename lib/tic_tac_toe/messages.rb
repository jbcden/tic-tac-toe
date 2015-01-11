class Messages
  def self.choose_a_character
    "Which player would you like to be? (\"x\" or \"o\") "
  end

  def self.announce_winner(winner)
    "The winner is: #{winner}"
  end

  def self.prompt_turn
    "Please choose a square to mark: "
  end

  def self.print_board(board)
    DisplayBoard.call(board)
  end
end
