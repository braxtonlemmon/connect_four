require "./bin/game.rb"
require "rspec"
describe Game do
	let(:game) { Game.new } 

	describe "#initialize" do
		it "should create Player One" do
			expect(game.player1).to be_truthy
		end

		it "should create Player Two" do
			expect(game.player2).to be_truthy
		end
	end

	describe "#welcome" do
		it "should display the welcome message" do
			message = game.welcome
			expect(game.welcome).to eq(message)
		end
	end
	
	describe "#swap_players" do
		context "before swapping" do
			it "current player should be player one" do
				expect(game.current_player).to eq(game.player1)
			end
		end
		context "after swapping" do
			it "reassigns the current player by swapping" do
				game.swap_players
				expect(game.current_player).to eq(game.player2)
			end
		end
	end

	describe "#make_move" do
		context "when choosing an available column" do
			it "should allow player to drop piece" do
				col = 3
				expect(game.make_move).to be_truthy
			end
		end

		context "when choosing a filled column" do
			it "should not allow player to drop piece" do
				col = 2
				board = game.board
				(0..5).each { |row| board.grid[row][col] = "x" }
				expect(game.make_move).to be_falsey
			end
		end
	end
end