class Player
	attr_reader :name, :token

	def initialize(name, token)
		@name = name
		@token = token
	end

end

class Slot
	attr_reader :value

	def initialize(value = '*')
		@value = value
	end
end
	
class Board
	attr_reader :layout

	def initialize
		@layout = create_board
	end

	def show
		puts "-----------------------------"

		layout.each do |row|
			row.each { |slot| print "| #{slot.value} " }
			print "|\n"
			puts "-----------------------------"
		end
	end	

	private
	def create_board
		Array.new(6) { Array.new(7) { Slot.new } }
	end
end

class Game
	attr_reader :board, :player1, :player2

	def initialize
		@board = Board.new
		@player1 = Player.new("Player 1", "\u25ce")
		@player2 = Player.new("Player 2", "\u25c9")
	end
end