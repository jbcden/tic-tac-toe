# An unbeatable game of tic-tac-toe!

[![Code Climate][CC img]][Code Climate]

[Code Climate]: https://codeclimate.com/github/jbcden/tic-tac-toe

[CC img]: https://codeclimate.com/github/jbcden/tic-tac-toe.png

## Setup:
- This can be played by cloning this repository and installing dependencies with:
```bash
bundle install
```
- Tests can be run by running:
```bash
rake test
```
The game itself can be run with
```bash
bin/game
```

## Gem:
For easy use of this program I have released a gem called jbcden_ttt.

For more information please go to https://github.com/jbcden/jbcden_ttt

## Notes:
- This game uses the minimax algorithm for its unbeatable computer player.
  - I learned about this algorithm from http://www.neverstopbuilding.com/minimax.
  - I also drew test cases based on examples from this article as well as a few ways to simplify the minimax algorithm.
- On a draw the winner is "cat".
- This is my first test-driven application so I am sure the tests could also be written better than they are now.
- I am also still new to Object-Oriented Design so any feedback on my design would be greatly appreciated!

## Things I would like to improve:
- I feel that the board
class may be doing too much. I am struggling to find a satisfying abstraction
and have decided to not change it for the time being.
- I also am not sure how to make the tests more flexible when it comes to
  testing the state of an object. I am not certain whether this means that my
objects(Computer and Board) are too coupled or if I am still too new at testing
to see a simple way to make the Computer tests more flexible.
