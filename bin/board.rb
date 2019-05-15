class Board
	attr_accessor :grid

	def initialize
		@grid = Array.new(6) { Array.new(7) { " " } }
	end

	def show
		grid.each { |row| p row }
	end

	def drop_piece(column)
		row = find_empty_spot(column)
		row ? (@grid[row][column] = "x") : false
	end

	def spot_empty?(row,column)
		(grid[row][column] == " ") ? true : false	
	end

	def find_empty_spot(col)
		5.downto(0) { |row| return row if spot_empty?(row,col) }
		false
	end

	def find_spot_value(row,column)
		grid[row][column]
	end

	def column_win?(column)
		5.downto(3) do |n|
			if (n-3..n).none? { |row| spot_empty?(row, column) }
				return true if (n-3..n).all? { |row| grid[row][column] == grid[n][column] }
			end
		end
		false
	end

	def row_win?(row)
		6.downto(3) do |n|
			if (n-3 ..n).none? { |column| spot_empty?(row, column) }
				return true if (n-3..n).all? { |column| grid[row][column] == grid[row][n] }
			end
		end
		false
	end

	def diagonal_win?(direction)
	  direction == 0 ? (range = [0,1,2]) : (range = [3,4,5])
		range.each do |n|
			4.times do |x|
				storage = []
				row = n
				column = x
				4.times do |i|
					storage << find_spot_value(row,column) unless spot_empty?(row, column)
					column += 1
					direction == 0 ? row += 1 : row -= 1
				end
				return true if (storage.length == 4) && (storage.uniq.size == 1)
			end	
		end
		false
	end

	#when checking for a win, only check the current column/row of dropped piece for efficiency

end