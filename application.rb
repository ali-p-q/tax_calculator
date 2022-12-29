PROMPT = ">"
PROMPT_WELCOME = "Welcome to TaxCalculator\n"
PROMPT_HEADER = "List of commands:\n"
PROMPT_COMMANDS = "run    calculate taxes
exit   quit program
help   prints extra information"
PROMPT_HELP = "\nAdd a file named input to the directory where the program is located.
The file should follow the format convention specified in README.md\n"

file = File.new('./input', 'r')

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
    # TODO
  end
end