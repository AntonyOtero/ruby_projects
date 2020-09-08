=begin
  
# TODO
~ add dynamic graphics
+ Fix | guess display not displaying correctly guessed letter
- allow for guessing the whole word, all-or-nothing
  
=end

require 'fileutils'

class Hangman
  attr_reader :selected_word
  attr_reader :graphics
  attr_reader :attempts
  attr_reader :letters_display
  attr_reader :guess_display
  
  
  def initialize
    FileUtils.mkdir "local/"
    FileUtils.mkdir "local/saves"
    FileUtils.copy "graphics.txt", "local/graphics_inst.txt"

    @dictionary = "5desk.txt"
    @graphics = "local/graphics_inst.txt"
    @selected_word = get_word
    @letters_display = "\na b c d e f g h i j k l m n o p q r s t u v w x y z\n\n"
    @guess_display = generate_guess(@selected_word)
    @attempts = 6
  end

  def get_word
    dictionary_arr = File.read(@dictionary).split("\r\n")
    words_in_range = dictionary_arr.select {|word| word.length.between?(5, 12)}
    return words_in_range.sample.downcase
  end

  def generate_guess(word)
    letter_arr = word.split("")
    hidden_arr = letter_arr.map {|letter| "_"}

    # "\n_ _ _ _ _ _ _ _ _\n\n"
    "\n" + hidden_arr.join(" ") + "\n\n"
  end

  def update_display(guess)
    if @attempts > 0 then
      # GUESS DISPLAY
      if @selected_word.include? guess then
        selected_arr = @selected_word.split("\n")
        selected_arr.each_with_index do |letter, index|
          if letter == guess then
            @guess_display[(index * 2) + 1] = guess
          end
        end
      else
        @attempts -= 1
        # GRAPHICS DISPLAY
        case @attempts
        when 5
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "|    ", "|    "].join("\n"))
        when 4
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "|  | ", "|    "].join("\n"))
        when 3
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "| /| ", "|    "].join("\n"))
        when 2
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "| /|\\", "|    "].join("\n"))
        when 1
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "| /|\\", "| /  "].join("\n"))
        when 0
          File.write(@graphics, ["____ ", "|  | ", "|  O ", "| /|\\", "| / \\"].join("\n"))
        end
      end
      # LETTERS DISPLAY
      if @letters_display.include? guess then
        @letters_display[@letters_display.index(guess)] = "-"
      end
      
      play
    end
  end

  def make_guess
    guess = ""
    loop do
      print "Guess a letter: "
      guess = gets.chomp.downcase
      if guess.length == 1
        break
      end
    end

    update_display(guess)
  end
  
  def play
    if @attempts == 0 then
      system("clear")
      puts File.read(@graphics)
      return  "\nYOU LOSE! The word was \"#{@selected_word}\"\n"
    end
    print @letters_display
    puts "DEBUG :: Attempts left: #{@attempts} | Word: #{@selected_word} :: DEBUG"
    puts File.read(@graphics)
    print @guess_display
    print make_guess
  end
end

new_game = Hangman.new
new_game.play