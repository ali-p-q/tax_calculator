require 'rspec'
require_relative '../helpers/input_parser'
require_relative '../model/line_item'

describe InputParser do
  subject(:instance) { Class.new.include(InputParser).new }
  let (:line_items) { [LineItem.new(3, "book at", 6.0)] }
  let (:scanned_line) { ["2", "books", "at", "10.0"] }
  let (:output_description) { "book at" }

  context "When parsing input" do
    it "singularizes descriptions" do
      expect(subject.singularized_description(scanned_line, 1..scanned_line.length - 2)).to eq(output_description)
    end
    it "returns parsed input" do
      expect(subject.parse('spec/input_with_equiv_description')).to eq(line_items)
    end
  end
end