# frozen_string_literal: true

module TaxCalculator
  TAX_RULES = 'config/rules.json'
  ROUNDING_STEP = 0.05
  def calculate_basic_tax_for(description, price)
    basic_tax = 0
    special_rule = false
    rules = JSON.parse(File.read(TAX_RULES), symbolize_names: true)
    rules[:tax_free_keyword_for][:book].each do |book_keyword|
      if description.include?(book_keyword)
        basic_tax = price * rules[:basic_sales_tax_rate_for][:book].to_f
        special_rule = true
      end
    end
    rules[:tax_free_keyword_for][:food].each do |food_keyword|
      if description.include?(food_keyword)
        basic_tax = price * rules[:basic_sales_tax_rate_for][:food].to_f
        special_rule = true
      end
    end
    rules[:tax_free_keyword_for][:medical].each do |medical_keyword|
      if description.include?(medical_keyword)
        basic_tax = price * rules[:basic_sales_tax_rate_for][:medical].to_f
        special_rule = true
      end
    end
    unless special_rule
      basic_tax = price * rules[:basic_sales_tax_rate_for][:all].to_f
      basic_tax = round_tax(basic_tax, ROUNDING_STEP)
    end
    return basic_tax
  end

  def calculate_import_duty_for(description, price)
    import_duty = 0
    rules = JSON.parse(File.read(TAX_RULES), symbolize_names: true)
    rules[:import_duty_keywords].each do |imported_keyword|
      if description.include?(imported_keyword)
        import_duty = price * rules[:import_duty_tax_rate].to_f
        import_duty = round_tax(import_duty, ROUNDING_STEP)
      end
    end
    return import_duty
  end

  def round_tax(tax_rate, step)
    remainder = tax_rate % step
    tax_rate = tax_rate - remainder
    unless remainder == 0
      return tax_rate + step
    end
    return tax_rate
  end
end
