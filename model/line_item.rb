# frozen_string_literal: true

class LineItem
  attr_accessor :quantity, :description, :price, :basic_tax, :import_duty
  def initialize(quantity, description, price)
    @quantity = quantity
    @description = description
    @price = price
    @basic_tax = 0
    @import_duty = 0
  end

  def ==(other)
    self.quantity == other.quantity &&
    self.description == other.description &&
    self.price == other.price &&
    self.basic_tax == other.basic_tax &&
    self.import_duty == other.import_duty
  end
end
