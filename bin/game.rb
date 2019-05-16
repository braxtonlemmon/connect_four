require_relative "board"
require_relative "player"


class Game
	attr_reader :player1, :player2, :board, :current_player, :location

	def initialize
		@player1 = Player.new
		@player2 = Player.new
		@board = Board.new
		@current_player = @player1
		@location = Array.new(2)
		puts welcome
	end

	def welcome
		<<~HEREDOC
				Welcome to Connect Four!
				
				Players each alternate dropping a token of their color (black or white) into
				an unfilled column of their choosing. The game is over once a player successfully places
				four consecutive tokens in a row horizontally, vertically, or diagonally. If the board is
				full and neither player has achieved four in a row, the game is a draw.
				
				Enjoy!
				
			HEREDOC
	end

	def swap_players
		@current_player = ((@current_player == @player1) ? @player2 : @player1 )
	end

	def make_move	
		puts "#{current_player.name}, please select a column:"
		@location = board.drop_piece(gets.chomp.to_i, current_player.piece)
	end

	def play
		while true
			board.show
			while true do break if make_move end
			return win_game_over if board.match?(location)
			return tie_game_over if board.full?
			swap_players
		end
	end

	def win_game_over
		board.show
		puts "Game over. #{current_player.name} wins!"
	end

	def tie_game_over
		board.show
		puts "It's a draw!"
	end
end

if __FILE__ == $0
	game = Game.new
	game.play
end
