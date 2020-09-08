=begin
  
# TODO
- fix how number of attempts remaining is tracked
- add dynamic graphics
- allow for guessing the whole word, all-or-nothing
  
=end

class Hangman
  attr_reader :selected_word
  attr_reader :graphics
  attr_reader :attempts
  attr_reader :letters_display
  attr_reader :guess_display
  
  def initialize
    @dictionary = File.read("5desk.txt")
    @graphics = File.read("graphics.txt")
    @selected_word = get_word
    @letters_display = "\na b c d e f g h i j k l m n o p q r s t u v w x y z\n\n"
    @guess_display = generate_guess(@selected_word)
    @attempts = 6
  end

  def get_word
    dictionary_arr = @dictionary.split("\r\n")
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
        selected_arr = @selected_word.split("")
        selected_arr.each_with_index do |letter, index|
          if letter == guess then
            @guess_display[(index * 2) + 1] = guess
          end
        end
      else
        @attempts -= 1
      end
      # LETTERS DISPLAY
      if @letters_display.include? guess then
        @letters_display[@letters_display.index(guess)] = "-"
      end
      
      play
    end
  end

  def make_guess
    # Does guess equal selected word?
    guess = ""
    loop do
      print "Guess: "
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
      puts @graphics
      return  "\nYOU LOSE! The word was \"#{@selected_word}\"\n"
    end
    print @letters_display
    # puts "DEBUG :: Attempts left: #{@attempts} :: DEBUG"
    puts "DEBUG :: Attempts left: #{@attempts} | Word: #{@selected_word} :: DEBUG"
    puts @graphics
    print @guess_display
    print make_guess
  end
end

new_game = Hangman.new
new_game.play