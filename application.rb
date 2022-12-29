require 'json'
require_relative 'line_item'

PROMPT = ">"
PROMPT_WELCOME = "Welcome to TaxCalculator\n"
PROMPT_HEADER = "List of commands:\n"
PROMPT_COMMANDS = "run    calculate taxes
exit   quit program
help   prints extra information"
PROMPT_HELP = "\nAdd a file named input to the directory where the program is located.
The file should follow the format convention specified in README.md\n"

puts PROMPT_WELCOME
puts PROMPT_HEADER
puts PROMPT_COMMANDS
print PROMPT
while true do
  input = gets.chomp
  if input == 'exit'
    break
  end
  if input == 'help'
    puts PROMPT_HELP
    puts PROMPT_HEADER
    puts PROMPT_COMMANDS
    print PROMPT
  end
  if input == 'run'
    # Import configuration rules
    file = File.read('./config.json')
    data_hash = JSON.parse(file)
    puts data_hash
    # Read input file and populate array
    line_items = []
    count = 0
    File.foreach('./input') do |each_line|
      array = each_line.scan(/\A[0-9]+ [\D\s]+ [0-9]+.[0-9]+\z/)
      # Split string: quantity, description, price
      line_items[count] = LineItem.new(array.first, array[1..array.length-2], array.last)
      count += 1
      # TODO: Calculate Basic Tax
        # TODO: Apply rules based on keywords
        # TODO: Round tax
      # TODO: Calculate Import Duty
        # TODO: Apply rules based on keywords
        # TODO: Round tax
    end
    total_tax = 0
    total = 0
    line_items.each do |li|
      puts li.quantity
      puts li.description
      puts li.price
      total_tax += li.basic_tax + li.import_duty
      total += li.price.to_f
    end
    puts "Sales Taxes: #{total_tax}"
    puts "Total: #{total}"
    print PROMPT
  end
end