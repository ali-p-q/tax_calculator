# frozen_string_literal: true

module UIHelper
  PROMPT = ">"
  PROMPT_WELCOME = "Welcome to TaxCalculator\n"
  PROMPT_HEADER = "List of commands:\n"
  PROMPT_COMMANDS = "run    calculate taxes
exit   quit program
help   prints extra information"
  PROMPT_HELP = "\nAdd a file named input to the directory where the program is located.
The file should follow the format convention specified in README.md\n"
  PROMPT_INVALID_INPUT = "Invalid input"

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

  def print_invalid_input_error
    puts PROMPT_INVALID_INPUT
    print PROMPT
  end

  def print_results_for(line_items)
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
  end
end
