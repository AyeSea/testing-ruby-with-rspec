class Player
	attr_reader :name, :token

	def initialize(name, token)
		@name = name
		@token = token
	end
end


class Slot
	attr_accessor :value

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
		puts "\n    |C1 |C2 |C3 |C4 |C5 |C6 |C7 |"
		puts "---------------------------------"

		layout.each_with_index do |row, i|
			print "|R#{i + 1} "

			row.each { |slot| print "| #{slot.value} " }
			
			print "|\n"
			puts "---------------------------------"
		end
	end

	def get_slot
		row = get_row
		col = get_col
		layout[row][col]
	end

	def update_slot(token)
		get_slot.value = token
	end

	def slot_empty?
		row = get_row
		col = get_col
		layout[row][col].value == "*" ? true : false
	end

	def valid_move?
		row = get_row
		col = get_col
		
		return true if row == 5
		layout[row + 1][col].value == "*" ? false : true
	end

	private
	def create_board
		Array.new(6) { Array.new(7) { Slot.new } }
	end

	def get_row
		puts "Select a row:"
		gets.chomp.to_i - 1
	end

	def get_col
		puts "Select a column:"
		gets.chomp.to_i - 1
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