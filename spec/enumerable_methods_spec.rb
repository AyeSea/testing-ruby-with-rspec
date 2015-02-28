require './enumerable_methods.rb'

describe Enumerable do
	before :each do
		@arr = [-2, -1, 0, 1, 2]
	end

	describe "#my_each" do
		it "returns an Array object" do
			expect(@arr.my_each { |num| num + 1}).to be_instance_of(Array)
		end

		it "returns self" do
			expect(@arr.my_each { |num| num + 1 }).to eq(@arr)
		end

		it "returns a blank Array object when calling object is blank Array object" do
			expect([].my_each { |num| num + 1}).to eq([])
		end

		context "raises error when" do
			it "no code block is supplied" do
				expect { @arr.my_each }.to raise_error(LocalJumpError)
			end

			it "object is not an Array object" do
				expect { nil.my_each }.to raise_error(NoMethodError)
				expect {   1.my_each }.to raise_error(NoMethodError)
				expect { "a".my_each }.to raise_error(NoMethodError)
			end
		end
	end

	describe "#my_select" do
		it "returns an Array object" do
			expect(@arr.my_select { |num| num < 0 }).to be_instance_of(Array)
		end

		it "returns new array with elements that evaluate to true in the supplied code block" do
			expect(@arr.my_select { |num| num > 0 }).to eq([1, 2])
		end

		it "returns a blank Array object when calling object is blank Array object" do
			expect([].my_select { |num| num > 0 }).to eq([])
		end

		context "raises error when" do
			it "no code block is supplied" do
				expect { @arr.my_select }.to raise_error(LocalJumpError)
			end

			it "object is not an Array object" do
				expect { nil.my_select }.to raise_error(NoMethodError)
				expect {   1.my_select }.to raise_error(NoMethodError)
				expect { "a".my_select }.to raise_error(NoMethodError)
			end
		end
	end

	describe "#my_all?" do
		it "returns a TrueClass object" do
			expect(@arr.my_all? { |num| num > -3 }).to be_instance_of(TrueClass)
		end

		it "returns true if all elements satisfy condition in code block" do
			expect(@arr.my_all? { |num| num > -3 }).to eq(true)
		end

		it "returns false if one or more elements does not satisfy condition in code block" do
			expect(@arr.my_all? { |num| num > 3 }).to eq(false)
		end

		it "returns true if object is blank array" do
			expect([].my_all? { |num| num > 3 }).to eq(true)
		end

		context "raises error when" do
			it "no code block is supplied" do
				expect { @arr.my_all? }.to raise_error(LocalJumpError)
			end

			it "object is not an Array object" do
				expect { nil.my_all? }.to raise_error(NoMethodError)
				expect {   1.my_all? }.to raise_error(NoMethodError)
				expect { "a".my_all? }.to raise_error(NoMethodError)
			end
		end
	end

	describe "#my_any?" do
		it "returns a TrueClass object" do
			expect(@arr.my_any? { |num| num > 0 }).to be_instance_of(TrueClass)
		end

		it "returns true if any element satisfies condition in code block" do
			expect(@arr.my_any? { |num| num > 1 }).to eq(true)
		end

		it "returns false if no elements satisfy condition in code block" do
			expect(@arr.my_any? { |num| num > 2 }).to eq(false)
		end

		it "returns false if object is blank array" do
			expect([].my_any? { |num| num > 1 }).to eq(false)
		end

		context "raises error when" do
			it "no code block is supplied" do
				expect { @arr.my_any? }.to raise_error(LocalJumpError)
			end

			it "object is not an Array object" do
				expect { nil.my_any? }.to raise_error(NoMethodError)
				expect {   1.my_any? }.to raise_error(NoMethodError)
				expect { "a".my_any? }.to raise_error(NoMethodError)
			end
		end
	end

	describe "#my_count" do
		it "returns a Fixnum object" do
			expect(@arr.my_count { |item| counter += 1 }).to be_instance_of(Fixnum)
		end

		it "returns the number of elements in the Array object when code block is supplied" do
			expect(@arr.my_count { |number| counter += 1 }).to eq(5)
		end

		it "returns the number of elements in the Array object when no code block is supplied" do
			expect(@arr.my_count).to eq(5)
		end

		it "returns 0 when the Array object is empty" do
			expect([].my_count { |number| counter += 1 }).to eq(0)
		end

		context "raises error when" do
			it "object is not an Array object" do
				expect { nil.my_count }.to raise_error(NoMethodError)
				expect {   1.my_count }.to raise_error(NoMethodError)
				expect { "a".my_count }.to raise_error(NoMethodError)
			end
		end
	end

	describe "#my_map" do
		it "returns an Array object" do
			expect(@arr.my_map { |num| num * 2 }).to be_instance_of(Array)
		end

		it "returns a new Array object where every element is updated according to the code block" do
			expect(@arr.my_map { |num| num * 2 }).to eq([-4, -2, 0, 2, 4])
		end

		it "returns a blank Array object when calling object is blank Array object" do
			expect([].my_map { |num| num * 2 }).to eq([])
		end

		it "returns a blank Array object when no code block is supplied" do
			expect(@arr.my_map).to eq([])
		end

		context "raises error when" do
			it "object is not an Array object" do
				expect { nil.my_count }.to raise_error(NoMethodError)
				expect {   1.my_count }.to raise_error(NoMethodError)
				expect { "a".my_count }.to raise_error(NoMethodError)
			end
		end
	end

end