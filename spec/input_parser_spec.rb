require 'rspec'
require_relative '../helpers/input_parser'
require_relative '../model/line_item'

describe InputParser do
  context “When testing the InputParser class” do
    let (:line_items) { [LineItem.new(3, "book at", 6.00)] }
    it "parses input" do
      input_parser = InputParser.new
      expect(input_parser.parse('test_input')).to eq(:line_items)
    end
  end
end