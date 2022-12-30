require 'json'
require_relative '../model/line_item'
require_relative '../helpers/tax_calculator'
require_relative '../helpers/input_parser'
require_relative '../helpers/ui_helper'

class Application
  INPUT_FILE = './input'
  include UIHelper
  include InputParser
  include TaxCalculator

  def run
    print_welcome_message
    while true do
      input = gets.chomp
      if input.eql?('exit')
        break
      elsif input.eql?( 'help')
        print_help_message
      elsif input.eql?( 'run')
        line_items = parse(INPUT_FILE)
        line_items.each do |item|
          item.basic_tax = calculate_basic_tax_for(item.description, item.price)
          item.import_duty = calculate_import_duty_for(item.description, item.price)
        end
        print_results_for(line_items)
      else
        print_invalid_input_error
      end
    end
  end
end