This project is based on The Odin Project's TDD curriculum:
(https://www.theodinproject.com/lessons/testing-your-ruby-code)

ASSIGNMENT 
Program a command-line Connect Four game using Test-Driven Development (TDD). Use RSpec framework for testing.

INTRODUCTION
The game is played by two players on a board of 7 columns and 6 rows. Players alternate dropping one piece into an unfilled column until a player aligns four consecutive pieces in a row horizontally, vertically, or diagonally. The game is a draw if the board fills up and neither player has achieved four in a row.  

<!-- I'm now going to brainstorm what my program will need (classes, methods, etc.):
There are two players that play the game. The game is played on a gameboard. The board is made up of a 7 column by 6 row board. 

Both players have a unique symbol representing their playing piece. Each player has a name.
Each player has a score, starting at zero.

A player can drop a piece into any column with available space. The piece drops to the lowest empty cell and fills that cell with the value of the piece. A player cannot drop a piece into a full column. 

The game ends when either (1) four identical pieces line up horizontally, vertically, or diagonally, or (2) the board fills up and neither player has won.

Actions:
 - take_turn
 - show_board
 - update_board
 - swap_players
 - win?
 - draw?
 - valid_play?
 - 

Classes:
- Player
	> Piece
	> Name
	> Score
	(Actions):
		= initialize

- Game
	> Player 1
	> Player 2
	> Gameboard
	> Current player

- Board
- Cell
	> Value -->
