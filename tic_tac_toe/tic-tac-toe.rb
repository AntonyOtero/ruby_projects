require 'pry'

class Game
  $memory = Array.new(9, " ")
  for i in 1..9 do
    $memory[i-1] = i
  end
  $players = [
    {:name => 'P1', :symbol => "X", :score => 0},
    {:name => 'P2', :symbol => "O", :score => 0}
  ]
  @current_player = $players[0]

  def display_board
    puts game_display = "
    | #{$memory[0]} | #{$memory[1]} | #{$memory[2]} |
    -------------
    | #{$memory[3]} | #{$memory[4]} | #{$memory[5]} |
    -------------
    | #{$memory[6]} | #{$memory[7]} | #{$memory[8]} |\n
    "
  end 
  def input
    @current_player = (@current_player == $players.first) ? $players.last : $players.first
    
    print "#{@current_player[:name]} select position (1-9): "
    player_input = gets.chomp.to_i
    while $memory[player_input.to_i - 1] == 'O' or $memory[player_input.to_i - 1] == 'X' do
      print "ERROR: Position Taken. Try Again.\n#{@current_player[:name]} select position (1-9): "
      player_input = gets.chomp.to_i
    end
    $memory[player_input.to_i - 1] = @current_player[:symbol]
    if [$memory[0] , $memory[1], $memory[2]].uniq.join == @current_player[:symbol] || [$memory[3] , $memory[4], $memory[5]].uniq.join == @current_player[:symbol] || [$memory[6] , $memory[7], $memory[8]].uniq.join == @current_player[:symbol] || [$memory[0] , $memory[3], $memory[6]].uniq.join == @current_player[:symbol] || [$memory[0] , $memory[4], $memory[8]].uniq.join == @current_player[:symbol] || [$memory[1] , $memory[4], $memory[7]].uniq.join == @current_player[:symbol] || [$memory[2] , $memory[5], $memory[8]].uniq.join == @current_player[:symbol] || [$memory[2] , $memory[4], $memory[6]].uniq.join == @current_player[:symbol]
      puts "#{@current_player[:name]} WINS!!!"
      puts "Game Over"
      self.display_board
      exit
    end
  end
  

    
end





new_game = Game.new()
9.times do
  new_game.display_board
  new_game.input
end

puts "IT'S A TIE!!!"
puts "Game Over"
new_game.display_board