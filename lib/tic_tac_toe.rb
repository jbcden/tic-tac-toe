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

clear_screen

print "Welcome to my Tic Tac Toe game! Which player would you like to be? (\"x\" or \"o\"): "

human_symbol = gets.chomp
player = Player.new(human_symbol)
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
  clear_screen
  print_board

  current_player = $players[$turn_num % 2]

  if current_player.human?
    puts
    move = gets.chomp
    current_player.make_move($board, move)
  else
    move = current_player.calculate_best_move($board, game)
    computer.make_move($board, move)
  end
  $turn_num += 1
  game = GameState.new($board, $turn_num, $players[$turn_num % 2])
end

clear_screen
print_board

puts "The winner is: #{game.end_state?}"
