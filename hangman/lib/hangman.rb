=begin
  
# TODO
- Fix | guess display not displaying correctly guessed letter
- Add | allowance for guessing the whole word, all-or-nothing
  
=end

require 'fileutils'

class Hangman
  # attr_reader :selected_word
  # attr_reader :graphics
  # attr_reader :attempts
  # attr_reader :letters_display
  # attr_reader :guess_display
  
  
  def initialize
    if Dir.exist?("local") then
      FileUtils.rm_rf "local"
      FileUtils.mkdir "local"
      FileUtils.mkdir "local/saves"
      FileUtils.copy "graphics.txt", "local/graphics_inst.txt"
    end

    @dictionary = "5desk.txt"
    @graphics = "local/graphics_inst.txt"
    @selected_word = generate_word
    @letters_ui = "\na b c d e f g h i j k l m n o p q r s t u v w x y z\n\n"
    @guess_ui = generate_guess_ui(@selected_word)
    @attempts = 6
  end

  def generate_word
    dictionary_arr = File.read(@dictionary).split("\r\n")
    words_in_range = dictionary_arr.select {|word| word.length.between?(5, 12)}
    return words_in_range.sample.downcase
  end

  def generate_guess_ui(word)
    letter_arr = word.split("")
    hidden_arr = letter_arr.map {|letter| "_"}
    "\n" + hidden_arr.join(" ") + "\n\n"
  end

  def update_guess_ui(guess)
    if @selected_word.include? guess then
      selected_arr = @selected_word.split("")
      selected_arr.each_with_index do |letter, index|
        if letter == guess then
          @guess_ui[(index * 2) + 1] = guess
        end
      end
    end
  end

  def update_graphics_ui(guess)
    if not @selected_word.include? guess then
      @attempts -= 1
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
  end

  def update_letters_ui(guess)
    if @letters_ui.include? guess then
      @letters_ui[@letters_ui.index(guess)] = "-"
    end
  end

  def update_ui(guess)
    if @attempts > 0 then
      update_guess_ui(guess)
      update_graphics_ui(guess)
      update_letters_ui(guess)
      play
    end
  end

  def get_guess
    guess = ""
    loop do
      print "Guess a letter: "
      guess = gets.chomp.downcase
      if guess.length == 1
        break
      end
    end
    update_ui(guess)
  end
  
  def get_graphics
    File.read(@graphics)
  end

  def display_ui
    # DEBUG
    puts "Atempts left: #{@attempts} | Word: #{@selected_word}"
    # DEBUG
    print @letters_ui
    puts get_graphics
    print @guess_ui
    print get_guess
  end

  def play
    if @attempts == 0 then
      system("clear")
      puts get_graphics
      puts"GAME OVER! The word was \"#{@selected_word}\""
    else
      display_ui
    end
  end
end

new_game = Hangman.new
new_game.play