# frozen_string_literal: true

class LineItem
  attr_accessor :quantity, :description, :price, :basic_tax, :import_duty
  def initialize(quantity, description, price, basic_tax, import_duty)
    @quantity = quantity
    @description = description
    @price = price
    @basic_tax = basic_tax
    @import_duty = import_duty
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end
end
