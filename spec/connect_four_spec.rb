require './connect_four.rb'

describe Player do
	let(:player) { Player.new("Homer", "\u25ce") }

	context "#initialize" do
		it "raises an error when no arguments are provided" do
			expect { Player.new }.to raise_error(ArgumentError)
		end

		it "has a name" do
			expect(player.name).to eq "Homer"
		end

		it "has a token" do
			expect(player.token).to eq "\u25ce"
		end
	end
end


describe Slot do
	context "#initialize" do
		it "has a default value of '*'" do
			expect(Slot.new.value).to eq "*"
		end
	end
end


describe Board do
	let(:board) { Board.new }

	context "#initialize" do
		it "creates a board with 6 rows" do
			expect(board.layout.size).to eq 6
		end

		it "creates 7 slots in each row" do
			expect(board.layout.all? { |row| row.size == 7 }).to be true
		end

		it "creates Slot objects in each row" do
			board.layout.each do |row|
				expect(row.all? { |slot| slot.class == Slot }).to be true
			end
		end
	end

	context "#update_slot" do
		it "updates slot at [5, 3] (1st row, center) to \u25ce" do
			expect(board.update_slot(5, 3, "\u25ce")).to eq board.layout[5][3] = "\u25ce"
		end
	end

	context "#slot_empty?" do
		it "returns true if slot at [5, 3] (1st row, center) has no token" do
			expect(board.slot_empty?(5, 3)).to be true
		end

		it "returns false if slot at [5, 3] (1st row, center) already has token" do
			board.update_slot(5, 3, "\u25ce")					
			expect(board.slot_empty?(5, 3)).to be false
		end
	end

	context "#valid_move?" do
		it "returns true when 1st move is a slot in the bottom (6th) row" do
			expect(board.valid_move?(5, 3)).to be true
		end

		it "returns false when 1st move is a slot in the 2nd-to-last (5th) row" do
			expect(board.valid_move?(4, 3)).to be false
		end
	end

	context "#outside_board?" do
		it "returns true for slot at [6, 3] (outside of board)" do
			expect(board.outside_board?(6, 3)).to be true
		end

		it "returns false for slot at [5, 3] (1st row, center)" do
			board.update_slot(5, 3, "\u25ce")
			expect(board.outside_board?(5, 3)).to be false
		end
	end
end


describe Game do
	let(:game) { Game.new }

	context "#initialize" do
		it "has one board and two players" do
			expect(game.board).to be_instance_of(Board)
			expect(game.player1).to be_instance_of(Player)
			expect(game.player2).to be_instance_of(Player)
		end

	end

	context "#switch_players" do
		it "returns player1 when number of turns is even" do
			expect(game.switch_players).to eq game.player1
		end

		it "returns player2 when number of turns is odd" do
			game.turn = 1
			expect(game.switch_players).to eq game.player2
		end
	end

	context "#board_full?" do
		it "returns true when no slots have value of *" do
			game.board.layout.flatten.map! { |slot| slot.value = "\u25ce" }
			expect(game.board_full?).to eq true
		end

		it "returns false when one or more slots has value of *" do
			game.board.layout[5][3].value = "\u25ce"			
			expect(game.board_full?).to eq false
		end
	end

	context "#victory?" do
		it "raises error when no arguments are passed in" do
			expect { game.victory? }.to raise_error(ArgumentError)
		end

		it "returns true if 3 same/consecutive tokens are below current slot" do
			[5, 4, 3, 2].each { |i| game.board.layout[i][3].value = "\u25ce" }
			expect(game.victory?(game.player1, 2, 3)).to be true
		end

		it "returns false if less than 3 same/consecutive tokens are below current slot" do
			[4, 3, 2].each { |i| game.board.layout[i][3].value = "\u25ce" }
			expect(game.victory?(game.player1, 2, 3,)).to be false
		end

		it "returns true if 1 same token to left and 2 same tokens to right of current slot" do
			[2, 3, 4, 5].each { |i| game.board.layout[5][i].value = "\u25ce" }
			expect(game.victory?(game.player1, 5, 3)).to be true
		end

		it "returns true if 2 same tokens to top-left and 1 to bottom-right of current slot" do
			game.board.layout[5][3].value = "\u25ce"
			game.board.layout[4][2].value = "\u25ce"
			game.board.layout[3][1].value = "\u25ce"
			game.board.layout[2][0].value = "\u25ce"
			expect(game.victory?(game.player1, 4, 2)).to be true
		end

		it "returns true if 2 same tokens to top-right and 1 to bottom-left of current slot" do
			game.board.layout[5][3].value = "\u25ce"
			game.board.layout[4][4].value = "\u25ce"
			game.board.layout[3][5].value = "\u25ce"
			game.board.layout[2][6].value = "\u25ce"
			expect(game.victory?(game.player1, 4, 4)).to be true
		end
		
	end
end