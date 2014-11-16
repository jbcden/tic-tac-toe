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

## Notes:
- This game uses the minimax algorithm for its unbeatable computer player. I learned about this algorithm from http://www.neverstopbuilding.com/minimax. I also drew test cases based on examples from this article as well as a few ways to simplify the minimax algorithm.
- On a draw the winner is "cat".
- This is my first test-driven application so I am sure the tests could also be written better than they are now.
- I am also still new to Object-Oriented Design so any feedback on my design would be greatly appreciated!

## Things I would like to improve:
- I have not dealt with error handling much in the past and I feel that I am currently handling error cases in a somewhat inelegant way.
- The design of the tic_tac_toe.rb file also feels clumsy and bloated.
