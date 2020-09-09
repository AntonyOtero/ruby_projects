=begin
  
# TODO
- Add | allowance for guessing the whole word, all-or-nothing
  
=end

require 'fileutils'
require 'json'

if not Dir.exist? "local" then
  FileUtils.mkdir "local"
  FileUtils.mkdir "local/saves"
end

def load
  data = JSON.parse(File.read "local/saves/saved.txt")
  Hangman.new data["selected_word"], data["letters_ui"], data["guess_ui"], data["attempts"]
end

def generate_word
  dictionary_arr = File.read("5desk.txt").split("\r\n")
  words_in_range = dictionary_arr.select {|word| word.length.between?(5, 12)}
  return words_in_range.sample.downcase
end

def generate_guess_ui(word)
  letter_arr = word.split("")
  hidden_arr = letter_arr.map {|letter| "_"}
  "\n" + hidden_arr.join(" ") + "\n\n"
end

class Hangman

  def initialize selected_word=generate_word, letters_ui="\na b c d e f g h i j k l m n o p q r s t u v w x y z\n\n", guess_ui=generate_guess_ui(selected_word), attempts=6

    @graphics = "local/graphics_inst.txt"
    @selected_word = selected_word
    @letters_ui = letters_ui
    @guess_ui = guess_ui
    @attempts = attempts
  end
  
  def save
    FileUtils.touch "local/saves/saved.txt"
    json = JSON.dump({"selected_word" => @selected_word, "letters_ui" => @letters_ui, "guess_ui" => @guess_ui, "attempts" => @attempts})
    File.write "local/saves/saved.txt", json
    puts "SAVED GAME."
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
      when 6
        File.write(@graphics, ["____ ", "|  | ", "|    ", "|    ", "|    "].join("\n"))
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
      if guess.length == 1 or guess == ":save"
        break
      end
    end
    (guess == ":save") ? save : update_ui(guess)
  end
  
  def get_graphics
    File.read(@graphics)
  end

  def display_ui
    # DEBUG
    # puts "Atempts left: #{@attempts} | Word: #{@selected_word}"
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
    elsif @guess_ui.slice(1, @guess_ui.length - 3).split(" ").join("") == @selected_word then
      system("clear")
      puts "YOU WON! You've guessed the word \"#{@selected_word}\""
    else
      system("clear")
      display_ui
    end
  end
end

selected_option = ""
loop do
  system("clear")
  print "Start a new game or load saved game (new/load): "
  selected_option = gets
  if selected_option == "new\n" or selected_option == "load\n" then
    break
  end
end

case selected_option
when "new\n"
  FileUtils.copy "graphics.txt", "local/graphics_inst.txt"
  new_game = Hangman.new
  new_game.play
when "load\n"
  saved_game = load
  saved_game.play
end