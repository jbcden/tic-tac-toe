#!/usr/bin/env ruby
require_relative 'tic_tac_toe/board'
require_relative 'tic_tac_toe/board_mapper'
require_relative 'tic_tac_toe/computer'
require_relative 'tic_tac_toe/display_board'
require_relative 'tic_tac_toe/game_state'
require_relative 'tic_tac_toe/player'
require_relative 'tic_tac_toe/tile'

$board = Board.new(3,3)
$turn_num = 0
$players = []

def choose_computer(human)
  if human == "x"
    return "o"
  else
    return "x"
  end
end

def clear_screen
  puts "\033c"
end

def print_board
  puts DisplayBoard.call($board)
end

def clear_board
  clear_screen
  print_board
end

clear_screen

print "Welcome to my Tic Tac Toe game!"

char_chosen = true
while char_chosen
  puts "Which player would you like to be? (\"x\" or \"o\"): "
  human_symbol = gets.chomp
  begin
    player = Player.new(human_symbol)
    char_chosen = false
  rescue Player::InvalidCharacterError => e
    puts e.message
    char_chosen = true
  end
end
computer = Computer.new(choose_computer(human_symbol))

if human_symbol == "x"
  $players << player
  $players << computer
else
  $players << computer
  $players << player
end

game = GameState.new($board, $turn_num, $players.first)


while !game.end_state?
  clear_board

  current_player = $players[$turn_num % 2]

  if current_player.human?
    puts
    moves=true
    while moves
      begin
        clear_board
        move = gets.chomp
        current_player.make_move($board, move)
        moves = false
      rescue BoardMapper::InvalidCoordinateError => e
        puts e.message
        moves = true
      end
    end
  else
    move = current_player.calculate_best_move($board, game)
    computer.make_move($board, move)
  end
  $turn_num += 1
  game = GameState.new($board, $turn_num, $players[$turn_num % 2])
end

clear_board

puts "The winner is: #{game.end_state?}"
