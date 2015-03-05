require './tictactoe.rb'

describe Player do
	let(:player1) { Player.new("Armin", "X") }
	let(:player2) { Player.new("Bart", "O") }

	context "#initialize" do
		it "should fail when no arguments are provided" do
			expect { Player.new }.to raise_error
		end

		it "should create/save a name" do
			expect(player1.name).to eq "Armin"
		end

		it "should create/save a mark" do
			expect(player1.mark).to eq "X"
		end
	end

	context "#select_box" do
		it "prompts user to select a box from 1 to 9" do
			expect { player1.select_box }.to output("Armin, please select a box (1 - 9):\n").to_stdout
		end

		it "saves user's response to @box" do
			allow(player1).to receive(:gets).and_return("1\n")
			player1.select_box
			expect(player1.box).to eq 1
		end
	end
end

describe Board do
	let(:board) { Board.new }

	context "#initialize" do
		it "creates an array of 8 possible win combos" do
			expect(board.win_combos.size).to eq 8
		end

		it "creates a board as a hash" do
			expect(board.current_board).to be_instance_of(Hash)
		end

		it "creates 9 boxes (key/value pairs) in the board hash" do
			expect(board.current_board.size).to eq 9
		end
	end

	context "#update_box" do
		it "raises an error when no arguments are provided" do
			expect { board.update_box }.to raise_error
		end

		it "updates a box in the board with the player's mark" do
			board.update_box(1, "X")
			expect(board.current_board[1]).to eq "X"
		end
	end

	context "#box_empty?" do
		it "returns true if box in board is empty" do
			expect(board.box_empty?(1)).to be true
		end

		it "returns false if box in board was filled with a player's mark" do
			board.update_box(1, "X")
			expect(board.box_empty?(1)).to be false
		end
	end
end

describe TicTacToe do
	let(:game) { TicTacToe.new }

	context "#initialize" do
		it "creates a new game with two players and a board" do
			expect(game.player1).to be_instance_of(Player)
			expect(game.player2).to be_instance_of(Player)
			expect(game.board).to be_instance_of(Board)
		end
	end

	context "#victory?" do
		it "returns true when player matches top row" do
			[1, 2, 3].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches middle row" do
			[4, 5, 6].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches bottom row" do
			[7, 8, 9].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches left column" do
			[1, 4, 7].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches middle column" do
			[2, 5, 8].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches right column" do
			[3, 6, 9].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches diagonal (top-left to bottom-right)" do
			[1, 5, 9].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns true when player matches diagonal (top-right to bottom-left)" do
			[3, 5, 7].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be true
		end

		it "returns false when player does not match winning combo" do
			[1, 2].each { |i| game.board.update_box(i, "X") }
			expect(game.victory?(game.player1)).to be false
		end
	end

	context "#draw?" do
		it "returns true when board is filled with marks" do
			(1..9).each { |i| game.board.update_box(i, "X") }
			expect(game.draw?).to be true
		end

		it "returns false if one or more boxes is not marked" do
			(1..8).each { |i| game.board.update_box(i, "X") }
			expect(game.draw?).to be false
		end
	end
end