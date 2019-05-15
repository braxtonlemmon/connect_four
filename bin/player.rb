class Player
	attr_reader :name, :piece
	
	@@count = 0

	def initialize
		@@count += 1
		if @@count == 1
			@name = "Player One"
			@piece = "\u26AA".encode('utf-8')
		else
			@name = "Player Two"
			@piece = "\u26AB".encode('utf-8')
		end
	end
end

