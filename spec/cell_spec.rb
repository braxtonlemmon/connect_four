require "./bin/cell"

describe Cell do
	let(:cell) { Cell.new }
	describe "#initialize" do
		it "cell has an empty value" do
			expect(cell.value).to eq(" ")
		end
	end
end
			