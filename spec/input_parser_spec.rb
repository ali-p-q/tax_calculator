require 'rspec'
require_relative '../helpers/input_parser'
require_relative '../model/line_item'

describe InputParser do
  subject(:instance) { Class.new.include(InputParser).new }
  let (:sum_of_line_items_with_equiv_description) { [LineItem.new(3, "imported book at", 6.0)] }
  let (:scanned_line) { ["2", "imported", "books", "at", "10.0"] }
  let (:expected_output) { "imported book at" }

  context "When parsing input" do
    it "singularizes descriptions" do
      expect(subject.singularized_description(scanned_line, 1..scanned_line.length - 2)).to eq(expected_output)
    end
    it "returns parsed input" do
      expect(subject.parse('spec/inputs_with_equiv_description')).to eq(sum_of_line_items_with_equiv_description)
    end
  end
end