=begin
# TODO
1. limit code input to 4
2. computer doesn't guess a number it already tried
3. feedback e.g. secret => 6444 guess => 6411
=end
class Codemaker
  attr_accessor :secret
  attr_accessor :feedback

  def initialize
    @secret = []
    @feedback = []
    # @score = 0
  end

  #PLAYER
  def set_secret()
    # until @secret.length == 4 do 
    print "Enter the secret code: "
    @secret = gets.chomp.split("")
    # end
    # @secret
  end

  def set_feedback() 
    print "Enter feedback: "
    @feedback = gets.chomp.split("")
  end
  
  #COMPUTER
  def gen_secret
    while @secret.length < 4
      @secret.push(rand(1..6))
    end
    @secret.map! {|num| num.to_s}
  end

end

class Codebreaker
  attr_accessor :guess

  def initialize
    @guess = []
  end

  #PLAYER
  def set_guess()
    # until @guess.length == 4 do
    print "Enter your guess: "
    @guess = gets.chomp.split("")
    # end
    # @guess
  end

  def gen_guess
    while @guess.length < 4
      @guess.push(rand(1..6))
    end
    @guess.map! {|num| num.to_s}
  end
end


class Mastermind
  attr_reader :codemaker
  attr_reader :codebreaker

  def initialize
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @secret_info = []
  end

  def get_secret
    @codemaker.secret
  end

  def get_guess
    @codebreaker.guess
  end

  def cpu_play
    # mismatch = [{index => 0, tried => [1,4,5]}]
    i = 0
    @codebreaker.guess = @codebreaker.gen_guess
    until @codebreaker.guess == @codemaker.secret  or i == 12 do
      print "Guess ##{i + 1}\n#{@codebreaker.guess}\n\n"
      @codebreaker.guess.each_with_index do |value, index|
        if value != @codemaker.secret[index] then
          @codebreaker.guess[index] = rand(1..6).to_s
        end
      end
      i += 1
    end
    print "Guess ##{i + 1}\n#{@codebreaker.guess}\n\n"
    @codebreaker.guess
  end

  def update_secret_info
    uniq_arr = @codemaker.secret.uniq
    secret_cpy = @codemaker.secret

    i = 0
    (uniq_arr.length).times do
      @secret_info[i] = {:num => uniq_arr[i], :indexes => []}
      j = 0
      (@codemaker.secret.count(@secret_info[i][:num])).times do
        @secret_info[i][:indexes].push(secret_cpy.index(@secret_info[i][:num]))
        secret_cpy[secret_cpy.index(@secret_info[i][:num])] = " "
        j += 1
      end
      i += 1
    end
    @secret_info
  end

  def gen_feedback
    i = 0
    @codemaker.feedback = []
    (@secret_info.length).times do
      if @codebreaker.guess.include? @secret_info[i][:num]
        j = 0
        (@secret_info[i][:indexes].length).times do
          if @codebreaker.guess[@secret_info[i][:indexes][j]] == @secret_info[i][:num]
            @codemaker.feedback.push('x')   
          else
            @codemaker.feedback.push('o')
          end
          j += 1
        end
      end
      i += 1
    end
    @codemaker.feedback
  end

  def play_game
    puts "      MASTERMIND       "
    puts "  ------------------  "
    puts " 1. Codemaker"
    print " 2. Codebreaker\n\n"
    print "Select your role (1-2): "
    player_role = gets.chomp
    if player_role == '1' then
      @codemaker.set_secret
      print "CPU will now guess...\n\n"
      cpu_play
    else 
      @codemaker.gen_secret
      update_secret_info
      print "CPU has written its secrete code: ####\n\n"
      i = 0
      until gen_feedback == ['x','x','x','x'] or i == 12 do
        @codebreaker.set_guess
        p gen_feedback
        i += 1
      end
      if gen_feedback == ['x','x','x','x'] then
       puts "YOU GUESSED RIGHT! YOU WIN!!!!"
      else
        puts "YOU LOST!!!!"
      end
      print "Play Again? (y/n): "
      play_again = gets.chomp
      if play_again == 'y'then
        play_game
      else
        puts "GOODBYE!"
      end
    end
  end
end

new_mastermind = Mastermind.new
new_mastermind.play_game


# new_mastermind = Mastermind.new
# p new_mastermind.codemaker.set_secret
# p new_mastermind.codebreaker.set_guess
# p new_mastermind.update_secret_info
# p new_mastermind.gen_feedback

=begin
  MAX_ROUNDS = 12
  MAX_GUESS = 4

  CODEBREAKER
    @guess => []
    PLAYER
    #set_guess(a, b, c, d) => @guess
    COMPUTER
    #gen_guess() => @guess

  SCORE
    Traditionally, players can only earn points when playing as the codemaker. The codemaker gets one point for each guess the codebreaker makes. An extra point is earned by the codemaker if the codebreaker is unable to guess the exact pattern within the given number of turns.

  CODE PEGS 
    @guess <= 6 

  KEY PEGS
    [x o]
    x= Correct color and placement
    o= Correct color but wrong placement 

  BOARD
    @board => []
    @codemaker => Codemaker.new
    @codebreaker => Codebreaker.new
    #start_game(rounds)
    #update_board(@guess, @feedback) => @board

    e.g.
    [{:guess => [6 3 2 5], :feedback => [o x]}, 
    {:guess => [1 3 4 2], :feedback => [x x o o]}, 
    {:guess => [1 3 4 2], :feedback => [x x x x]}]

  CODEMAKER
    @secret => []
    @feedback => []
    @score => 0
    PLAYER
    #set_secret(a, b, c, d) => @secret
    #set_feedback(a, b, c, d) => @feedback
    COMPUTER
    #gen_secret() => @secret
    #gen_feedback() => @feedback
=end