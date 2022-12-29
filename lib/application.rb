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

  def run
    print_welcome_message
    while true do
      input = gets.chomp
      if input == 'exit'
        break
      elsif input == 'help'
        print_help_message
      elsif input == 'run'
        # Parse input file
        line_items = []
        File.foreach(INPUT_FILE_PATH) do |each_line|
          puts "Scanning line: #{each_line}"
          scanned_strings = each_line.scan(/[0-9a-zA-Z\.]+/)
          puts "Scanned as: #{scanned_strings}"
          (1..scanned_strings.length - 2).each do |index|
            puts "Singularizing #{scanned_strings[index]}"
            scanned_strings[index] = lame_singularize(scanned_strings[index])
            puts "Singularized to: #{scanned_strings[index]}"
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
          unless updated
            line_items.push(LineItem.new(quantity, description, price))
          end
          # Import tax rules
          file = File.read(JSON_PATH)
          data_hash = JSON.parse(file)
          puts data_hash
          # Calculate Basic Tax

          # TODO: Round tax
          # TODO: Calculate Import Duty
          # TODO: Apply rules based on keywords
          # TODO: Round tax
        end
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