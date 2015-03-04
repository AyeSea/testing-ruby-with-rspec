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