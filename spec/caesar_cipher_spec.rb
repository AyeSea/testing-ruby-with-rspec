require './caesar_cipher.rb'

describe "#caesar_cipher" do
	it "returns original string when no shift value is given" do
		expect(caesar_cipher("lupin")).to eq("lupin")
	end

	it "shifts each character by the specified shift value" do
		expect(caesar_cipher("apple", 1)).to eq("bqqmf")
	end
		
	it "remembers whether letter was upper or lowercase" do
		expect(caesar_cipher("Apple", 1)).to eq ("Bqqmf")
	end

	it "doesn't shift values for non-alphabetic characters" do
		expect(caesar_cipher("Apples and Oranges!", 1)).to eq("Bqqmft boe Psbohft!")
	end

	it "loops from z to a" do
		expect(caesar_cipher("zebra", 1)).to eq("afcsb")
	end

	it "loops from Z to A" do
		expect(caesar_cipher("Zebra", 1)).to eq("Afcsb")
	end
end