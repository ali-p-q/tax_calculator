require 'rspec'
require_relative '../helpers/tax_calculator'
require "bigdecimal/util"

describe TaxCalculator do
  subject(:instance) { Class.new.include(TaxCalculator).new }
  context "When calculating tax rates" do
    it "rounds tax" do
      expect(subject.round_tax(10.01.to_d, 0.05.to_d)).to eq(10.05)
      expect(subject.round_tax(10.06.to_d, 0.05.to_d)).to eq(10.1)
    end
    it "calculates basic tax" do
      expect(subject.calculate_basic_tax_for("book", 10)).to eq(0)
      expect(subject.calculate_basic_tax_for("food", 10)).to eq(0)
      expect(subject.calculate_basic_tax_for("medical", 10)).to eq(0)
      expect(subject.calculate_basic_tax_for("something", 10)).to eq(1)
      expect(subject.calculate_basic_tax_for("something", 3)).to eq(0.3)
    end
    it "calculates import duty" do
      expect(subject.calculate_import_duty_for("imported", 10)).to eq(0.5)
      expect(subject.calculate_import_duty_for("imported", 1)).to eq(0.05)
      expect(subject.calculate_import_duty_for("imported", 0.05)).to eq(0.05)
    end
  end

end
