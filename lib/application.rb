require 'json'
require_relative 'line_item'

class Application
  PROMPT = ">"
  PROMPT_WELCOME = "Welcome to TaxCalculator\n"
  PROMPT_HEADER = "List of commands:\n"
  PROMPT_COMMANDS = "run    calculate taxes
exit   quit program
help   prints extra information"
  PROMPT_HELP = "\nAdd a file named input to the directory where the program is located.
The file should follow the format convention specified in README.md\n"
  PROMPT_INVALID_INPUT = "Invalid input"
  INPUT_FILE_PATH = './input'
  JSON_PATH = 'config/rules.json'
  ROUNDING_STEP = 0.05

  def run
    print_welcome_message
    while true do
      input = gets.chomp
      if input == 'exit'
        break
      elsif input == 'help'
        print_help_message
      elsif input == 'run'
        # Import tax rules
        file = File.read(JSON_PATH)
        rules = JSON.parse(file, symbolize_names: true)
        puts rules
        # Parse input file
        line_items = []
        File.foreach(INPUT_FILE_PATH) do |each_line|
          scanned_strings = each_line.scan(/[0-9a-zA-Z\.]+/)
          (1..scanned_strings.length - 2).each do |index|
            scanned_strings[index] = lame_singularize(scanned_strings[index])
          end
          # Cast to appropriate types
          quantity = scanned_strings.first.to_i
          description = scanned_strings[1..scanned_strings.length - 2].join(" ")
          price = scanned_strings.last.to_f
          # Create an array of items with unique description
          updated = false
          line_items.each do |li|
            if li.description == description
              li.quantity += quantity
              li.price += price
              updated = true
              break
            end
          end
          # Create new line item
          unless updated
            # Calculate basic tax
            basic_tax = 0
            special_rule = false
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
            # Calculate import duty
            import_duty = 0
            rules[:import_duty_keywords].each do |imported_keyword|
              if description.include?(imported_keyword)
                import_duty = price * rules[:import_duty_tax_rate].to_f
                import_duty = round_tax(import_duty, ROUNDING_STEP)
              end
            end
            line_items.push(LineItem.new(quantity, description, price, basic_tax, import_duty))
          end
        end
        # Print results
        total_tax = 0
        total = 0
        line_items.each do |li|
          puts "#{li.quantity} #{li.description} #{li.price}"
          total_tax += li.basic_tax + li.import_duty
          total += li.price.to_f
        end
        puts "Sales Taxes: #{total_tax}"
        puts "Total: #{total}"
        print PROMPT
      else
        puts PROMPT_INVALID_INPUT
        print PROMPT
      end
    end
  end

  def round_tax(tax_rate, step)
    remainder = tax_rate % step
    tax_rate = tax_rate - remainder
    unless remainder == 0
      return tax_rate + step
    end
    return tax_rate
  end

  def print_welcome_message
    puts PROMPT_WELCOME
    puts PROMPT_HEADER
    puts PROMPT_COMMANDS
    print PROMPT
  end

  def print_help_message
    puts PROMPT_HELP
    puts PROMPT_HEADER
    puts PROMPT_COMMANDS
    print PROMPT
  end

  def lame_singularize(str)
    # TODO: Implement a smarter singularize (or use Rails)
    if str.eql?("boxes")
      return "box"
    elsif str.eql?("packets")
      return "packet"
    elsif str.eql?("bottles")
      return "bottle"
    else
      return str
    end
  end
end