require "./bin/player"

describe Player do
	it "resets class variable @@count to 0" do
		Player.class_variable_set(:@@count, 0)
		expect(Player.class_variable_get(:@@count)).to eq(0)
	end
		
	describe "#initialize" do
		context "when creating player one" do
			before(:all) { @player_one = Player.new }

			it "sets playing piece to white" do
				expect(@player_one.piece).to eq("⚪")
			end
			it "sets name to Player One" do
				expect(@player_one.name).to eq("Player One")
			end
		end

		context "when creating player two" do
			before(:all) { @player_two = Player.new }

			it "sets name to Player 2" do
				expect(@player_two.name).to eq("Player Two")
			end

			it "sets playing piece to black circle" do
				expect(@player_two.piece).to eq("⚫")
			end
		end
	end
end


