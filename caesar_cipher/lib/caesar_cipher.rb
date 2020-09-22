# Define a function to capture and return a users input
def get_string
  # Prompt user for input
  print 'Enter a string: '
  # Capture user input formatted with no line-break
  input_str = gets.chomp

  # Return user input
  input_str
end

# Define a function to capture and return a users input as number >=24 / gives you three chances
def get_number
  chances = 0
  input_num = 26
  until input_num.abs < 26
    puts "YOU'RE AN IDIOT" if chances == 3
    print 'Enter a number (less than 26): '
    input_num = gets.chomp.to_i
    chances += 1
  end

  input_num
end

def caesar_cipher(string, number)
  return string.bytes.map { |ascii|
         if ascii.between?(65, 90)
           if ascii + number > 90
             ascii = 64 + ((ascii + number) % 90)
             ascii.chr
           else
             (ascii + number).chr
           end
         elsif ascii.between?(97, 122)
           if ascii + number > 122
             ascii = 96 + ((ascii + number) % 122)
             ascii.chr
           else
             (ascii + number).chr
           end
         else
           ascii.chr
         end
       }.join
end

puts caesar_cipher(get_string, get_number)