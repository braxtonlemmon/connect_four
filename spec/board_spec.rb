require "./bin/board.rb"

describe Board do
	let(:board) { Board.new }

	describe "#initialize" do
		it "contains an empty 6x7 grid" do
			expect(board.grid).to eq(Array.new(6) { Array.new(7) { " " } })
		end
	end

	describe "#show" do
		it "prints grid to screen" do
			rows = board.grid
			printed_grid = rows.each { |row| p row }
			expect(board.show).to eq(printed_grid)
		end
	end

	describe "#drop_piece" do
		context "when column is not full" do	
			it "changes value in grid array" do
				col = 4
				board.drop_piece(col)
				expect(board.grid[5][col]).not_to eq(" ")
			end

			it "adds piece to lowest empty spot in column" do
				col = 1
				5.downto(3) { |row| board.grid[row][col] = "x" }	
				board.drop_piece(col)
				expect(board.grid[2][col]).to eq("x")
			end 
		end
		
		context "when column is full" do
			it "returns false" do
				col = 4
				(0..5).each { |row| board.grid[row][col] = "x" }
				expect(board.drop_piece(col)).to eq(false)
			end
		end
	end

	describe "#spot_empty?" do
		context "when spot is empty" do
			it "returns true" do
				expect(board.spot_empty?(5,1)).to eq(true)
			end
		end

		context "when spot is filled" do
			it "returns false" do
				board.grid[5][0] = "x"
				expect(board.spot_empty?(5,0)).to eq(false)
			end
		end
	end

	describe "#find_empty_spot" do
		context "when column not full" do
			it "returns row index of lowest empty spot in column" do
				col = 3
				board.grid[5][col] = "x"
				board.show
				expect(board.find_empty_spot(col)).to eq(4)
			end
		end

		context "when column is full" do
			it "returns false" do
				col = 2
				(0..5).each { |row| board.grid[row][col] = "x" }
				expect(board.find_empty_spot(col)).to eq(false)
			end
		end
	end

	describe "#find_spot_value" do
		context "when spot is empty" do
			it "returns a value of ' '" do
				expect(board.find_spot_value(3,4)).to eq(" ")
			end
		end

		context "when spot is occupied" do
			it "returns the utf character in the spot" do
				board.grid[2][2] = "⚪"
				expect(board.find_spot_value(2,2)).to eq("⚪")
			end
		end
	end

	describe "#column_win?" do
		context "when column is empty" do
			it "returns false" do
				col = 3
				expect(board.column_win?(col)).to eq(false)
			end
		end

		context "when column has three pieces" do
			it "returns false" do
				col = 3
				3.times { board.drop_piece(col) }
				expect(board.column_win?(col)).to eq(false)
			end
		end

		describe "when column is full" do
			col = 2
			context "when there is no match" do
				it "returns false" do
					(0..5).each { |row| board.grid[row][col] = "x" }
					board.grid[3][col] = "o"
					expect(board.column_win?(col)).to eq(false)
				end
			end

			context "when there is a match" do
				it "returns true" do
					(0..5).each { |row| board.grid[row][col] = "x" }
					expect(board.column_win?(col)).to eq(true)
				end
			end
		end
	end

	describe "#row_win?" do
		context "when row is empty" do
			it "returns false" do
				expect(board.row_win?(5)).to eq(false)
			end
		end

		describe "when row is partially full" do
			row = 5
			context "when there is a match" do
				it "returns true" do
					(2..5).each { |col| board.grid[row][col] = "x" }
					expect(board.row_win?(row)).to eq(true)
				end
			end

			context "when there is no match" do
				it "returns false" do
					(2..4).each { |col| board.grid[row][col] = "x" }
					(5..6).each { |col| board.grid[row][col] = "o" }
					expect(board.row_win?(row)).to eq(false)
				end
			end
		end

		describe "when row is full" do
			row = 5
			context "when there is a match" do
				it "returns true" do
					(0..3).each { |col| board.grid[row][col] = "x" }
					(4..6).each { |col| board.grid[row][col] = "o" }
					expect(board.row_win?(row)).to eq(true)
				end
			end

			context "when there is no match" do
				it "returns false" do
					[0, 2, 5].each { |col| board.grid[row][col] = "x" }
					[1, 3, 4, 6].each { |col| board.grid[row][col] = "o" }
					expect(board.row_win?(row)).to eq(false)
				end
			end
		end
	end

	describe "#diagonal_win?" do
		context "when diagonal is 'backslash' direction" do
			context "when diagonal is empty" do
				it "returns false" do
					expect(board.diagonal_win?(0)).to eq(false)
				end
			end

			context "when diagonal is partially full" do
				it "returns false" do
					(0..2).each { |n| board.grid[n][n] = "x" }
					expect(board.diagonal_win?(0)).to eq(false)
				end
			end

			context "when diagonal is full" do
				context "when there is no match" do
					it "returns false" do
						[1, 3].each { |n| board.grid[n][n] = "x" }
						[0, 2].each { |n| board.grid[n][n] = "o" }
						expect(board.diagonal_win?(0)).to eq(false)
					end
				end
				
				context "when there is a match" do
					it "returns true" do
						(0..3).each { |n| board.grid[n][n] = "x" }
						expect(board.diagonal_win?(0)).to eq(true)
					end

					it "returns true" do
						(2..5).each { |n| board.grid[n][n-1] = "x" }
						expect(board.diagonal_win?(0)).to eq(true)
					end
				end
			end
		end

		context "when diagonal is 'forward slash' direction" do
			context "when diagonal is empty" do
				it "returns false" do
					expect(board.diagonal_win?(1)).to eq(false)
				end
			end
	
			context "when diagonal is partially full" do
				it "returns false" do
					col = 0
					3.downto(1) do |row|
						board.grid[row][col] = "x"
						col += 1
					end
					expect(board.diagonal_win?(1)).to eq(false)
				end
			end
	
			context "when diagonal is full" do
				context "when there is no match" do
					it "returns false" do
						board.grid[5][2] = "x"
						board.grid[4][3] = "o"
						board.grid[3][4] = "x"
						board.grid[2][5] = "x"
						expect(board.diagonal_win?(1)).to eq(false)
					end
				end
				
				context "when there is a match" do
					it "returns true" do
						col = 0
						3.downto(0) do |row|
							board.grid[row][col] = "x"
							col += 1
						end
						expect(board.diagonal_win?(1)).to eq(true)
					end
	
					it "returns true" do
						col = 0
						4.downto(1) do |row|
							board.grid[row][col] = "x"
							col += 1
						end
						expect(board.diagonal_win?(1)).to eq(true)
					end
				end
			end
		end
	end
	
end
