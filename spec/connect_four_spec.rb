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

	before :each do
		allow(board).to receive(:gets).and_return("6\n", "4\n")
	end

	context "#get_slot" do
		it "points to slot at [5, 3] (1st row, center)" do
			expect(board.get_slot).to eq board.layout[5][3]
		end
	end

	context "#update_slot" do
		it "updates slot at [5, 3] (1st row, center) to \u25ce" do
			expect(board.update_slot("\u25ce")).to eq board.layout[5][3] = "\u25ce"
		end
	end

	context "#slot_empty?" do
		it "returns true if slot at [5, 3] (1st row, center) has no token" do
			expect(board.slot_empty?).to be true
		end

		it "returns false if slot at [5, 3] (1st row, center) already has token" do
			board.update_slot("\u25ce")			
			allow(board).to receive(:gets).and_return("6\n", "4\n")			
			expect(board.slot_empty?).to be false
		end
	end

	context "#valid_move?" do
		it "returns true when 1st move is a slot in the bottom (6th) row" do
			expect(board.valid_move?).to be true
		end

		it "returns false when 1st move is a slot in the 2nd-to-last (5th) row" do
			allow(board).to receive(:gets).and_return("5\n", "4\n")
			expect(board.valid_move?).to be false
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

end