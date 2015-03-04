require './tictactoe.rb'

describe Player do
	it "has a name"

	it "has a mark, where X is assigned to the 1st player instance and O to the 2nd"

end


describe Board do
	before :each do
		@board = Board.new
	end

	it "has an array of possible winning combos"

	it "creates a default board when instantiated"

	it "can show the current board"

	it "can have the values of its cells updated"

	it "has a check to see if a cell is empty"

end

describe TicTacToe do
	before :each do
		@game = TicTacToe.new
	end
	it "has two players and a board"

	it "keeps track of player turns"

	it "ends the game when a user matches a winning combo"

	it "ends the game with a tie when all cells are filled"

	it "ends the game with a victory if all cells are filled but a player matches a winning combo"
end