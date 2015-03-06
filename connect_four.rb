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

	def get_row
		puts "Select a row:"
		gets.chomp.to_i - 1
	end

	def get_col
		puts "Select a column:"
		gets.chomp.to_i - 1
	end

	def update_slot(row, col, token)
		layout[row][col].value = token
	end

	def slot_empty?(row, col)
		layout[row][col].value == "*" ? true : false
	end

	def valid_move?(row, col)
		return true if row == 5
		layout[row + 1][col].value == "*" ? false : true
	end

	def outside_board?(row, col)
		row.between?(0, 5) && col.between?(0, 6) ? false : true
	end

	private
	def create_board
		Array.new(6) { Array.new(7) { Slot.new } }
	end

end


class Game
	attr_reader :board, :player1, :player2, :players, :row, :col
	attr_accessor :turn

	def initialize
		@board = Board.new
		@player1 = Player.new("Player 1", "\u25ce")
		@player2 = Player.new("Player 2", "\u25c9")
		@players = [player1, player2]
		@turn = 0
	end

	def switch_players
		turn % 2 == 0 ? player1 : player2
	end

	def board_full?
		board.layout.all? do |row|
			row.all? { |slot| slot.value != "*" }
		end
	end

	def run
		loop do
			player = switch_players
			puts "#{player.name}'s turn!"
			board.show
			row = board.get_row
			col = board.get_col

			if board.slot_empty?(row, col) && board.valid_move?(row, col)
				board.update_slot(row, col, player.token)
			elsif !board.slot_empty?(row, col)
				puts "That slot is already taken. Please try again.\n"
				redo
			elsif !board.valid_move?(row, col)
				puts "That is not a valid move. Please try again.\n"
				redo
			end

			if victory?(player, row, col)
				board.show
				puts "######################"
				puts "#{player.name} wins!"
				puts "######################"
				exit
			else
				@turn += 1
			end
		end
	end

	def victory?(player, row, col)
		#VERTICAL TEST
		grid = board.layout
		vert = []
		i = 1

		while i < 4
			break if board.outside_board?(row + i, col)

			if grid[row + i][col].value == player.token
				vert << player.token
				i += 1
			else
				break
			end
		end

	 #LEFT TEST
		left = []
		i = 1

		while i < 4
			break if board.outside_board?(row, col - i)

	 		if grid[row][col - i].value == player.token
	 			left << player.token
	 			i += 1
	 		else
	 			break
	 		end
		end

	 #RIGHT TEST
	 right = []
	 i = 1

		while i < 4
	 		break if board.outside_board?(row, col + i)

	 		if grid[row][col + i].value == player.token
	 			right << player.token
	 			i += 1
	 		else
	 			break
	 		end
	 	end

	horiz = left + right

	#DIAGONAL (NW) TEST
	top_left = []
	i = 1

	while i < 4
		break if board.outside_board?(row - i, col - i)

		if grid[row - i][col - i].value == player.token
			top_left << player.token
			i += 1
		else
			break
		end
	end

	#DIAGONAL (SE) TEST
	bottom_right = []
	i = 1

	while i < 4
		break if board.outside_board?(row + i, col + i)

		if grid[row + i][col + i].value == player.token
			bottom_right << player.token
			i += 1
		else
			break
		end
	end

	desc_diagonal = top_left + bottom_right

	#DIAGONAL (NE) TEST
	top_right = []
	i = 1

	while i < 4
		break if board.outside_board?(row - i, col + i)

		if grid[row - i][col + i].value == player.token
			top_right << player.token
			i += 1
		else
			break
		end
	end

	#DIAGONAL (SW) TEST
	bottom_left = []
	i = 1

	while i < 4
		break if board.outside_board?(row + i, col - i)

		if grid[row + i][col - i].value == player.token
			bottom_left << player.token
			i += 1
		else
			break
		end
	end

	asc_diagonal = top_right + bottom_left

	vert.size == 3 || horiz.size == 3 || desc_diagonal.size == 3 || asc_diagonal.size == 3 ? true : false

	end
end