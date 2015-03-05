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

	context "#get_slot" do
		xit "points to slot at (x,y)" do

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