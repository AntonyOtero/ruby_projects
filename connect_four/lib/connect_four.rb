class Player
  attr_reader :name, :token
  attr_accessor :score

  def initialize(name, token, score)
    @name = name
    @token = token
    @score = score
  end
end

class ConnectFour
  def initialize
    @memory = [
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ']
    ]
    @board
    @column = []
    @row = []
    @diagonal_left = []
    @diagonal_right = []
    @search_data = []
    @player_one = Player.new('P1', '⚈', 0)
    @player_two = Player.new('P2', '⚆', 0)
    @current_player = @player_one
  end

  def display_board
    puts @board
  end
  
  def new_board
    clear
    @memory = [
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ']
    ]

    @board = %(
      | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
      -----------------------------      
      
      |   |   |   |   |   |   |   |
      -----------------------------
      |   |   |   |   |   |   |   |
      -----------------------------
      |   |   |   |   |   |   |   |
      -----------------------------
      |   |   |   |   |   |   |   |
      -----------------------------
      |   |   |   |   |   |   |   |
      -----------------------------
      |   |   |   |   |   |   |   |
    )

    display_board
  end


  def update_board
    @board = %(
      | 1 | 2 | 3 | 4 | 5 | 6 | 7 |

      | #{@memory[0][5]} | #{@memory[1][5]} | #{@memory[2][5]} | #{@memory[3][5]} | #{@memory[4][5]} | #{@memory[5][5]} | #{@memory[6][5]} |
      -----------------------------
      | #{@memory[0][4]} | #{@memory[1][4]} | #{@memory[2][4]} | #{@memory[3][4]} | #{@memory[4][4]} | #{@memory[5][4]} | #{@memory[6][4]} |
      -----------------------------
      | #{@memory[0][3]} | #{@memory[1][3]} | #{@memory[2][3]} | #{@memory[3][3]} | #{@memory[4][3]} | #{@memory[5][3]} | #{@memory[6][3]} |
      -----------------------------
      | #{@memory[0][2]} | #{@memory[1][2]} | #{@memory[2][2]} | #{@memory[3][2]} | #{@memory[4][2]} | #{@memory[5][2]} | #{@memory[6][2]} |
      -----------------------------
      | #{@memory[0][1]} | #{@memory[1][1]} | #{@memory[2][1]} | #{@memory[3][1]} | #{@memory[4][1]} | #{@memory[5][1]} | #{@memory[6][1]} |
      -----------------------------
      | #{@memory[0][0]} | #{@memory[1][0]} | #{@memory[2][0]} | #{@memory[3][0]} | #{@memory[4][0]} | #{@memory[5][0]} | #{@memory[6][0]} |
    )
    display_board
  end

  def get_input
    print "#{@current_player.name} select column (1-7): "
    selected_column = 0
    loop do
      selected_column = gets.chomp.to_i - 1
      if not selected_column.between?(0,6) then
        print "ERROR: Input has to be between 1-7: "
      else
        break
      end
    end
    selected_column
  end

  def set_column_data(selected_column)
    @column = @memory[selected_column]
  end

  def insert_token_at(column, index)
    @memory[column][index] = @current_player.token
  end

  def get_first_empty_index(input)
    @memory[input].find_index " "
  end

  def get_position_data(input)
    
    if @memory[input].find_index(" ") == nil then
      clear
      display_board
      puts "ERROR: COLUMN #{input + 1} IS FULL!"
      get_position_data(get_input)
    else
      set_column_data(input)
      first_empty_index = get_first_empty_index(input)
      
      insert_token_at(input, first_empty_index)
      position_data = {:column => input, :row => first_empty_index}

      position_data
    end
  end

  def set_row_data(position_data)
    updated_row = []
    for x in 0..6 do
      updated_row.push(@memory[x][position_data[:row]])
    end
    @row = updated_row
    # row = {:start => "#{0}#{last_pos[:row]}", :end => "#{6}#{last_pos[:row]}"}
    # "#{row[:start]}#{row[:end]}"
  end

  def set_diagonal_left_data(position_data)
    updated_diagonal_left = []
    # Diagonal left start position
    if position_data[:column] == 0 || position_data[:row] == 5 then
      diagonal_column_start = position_data[:column]
      diagonal_row_start = position_data[:row]
    else
      diagonal_column_start = (position_data[:column] + position_data[:row]) - ((position_data[:column] + position_data[:row]) % 5)
      diagonal_row_start = (position_data[:column] + position_data[:row]) % 5
    end

    # Diagonal left end position
    if position_data[:col] == 6 || position_data[:row] == 0 then
      diagonal_column_end = position_data[:column]
      diagonal_row_end = position_data[:row]
    else
      diagonal_column_end = (position_data[:column] + position_data[:row]) % 6
      diagonal_row_end = (position_data[:column] + position_data[:row]) - ((position_data[:column] + position_data[:row]) % 6)
    end

    # current
    diagonal_column = diagonal_column_start
    diagonal_row = diagonal_row_start

    until diagonal_column > diagonal_column_end do
      updated_diagonal_left.push(@memory[diagonal_column][diagonal_row])
      diagonal_column += 1
      diagonal_row -= 1
    end

    @diagonal_left = updated_diagonal_left
    # dl_coor = {:start => "#{diagonal_col_start}#{diagonal_row_start}", :end => "#{diagonal_col_end}#{diagonal_row_end}"}
    # "#{dl_coor[:start]}#{dl_coor[:end]}"
  end

  def set_diagonal_right_data(position_data)
    updated_diagonal_right = []
    # Diagonal right start position
    if position_data[:column] == 0 or position_data[:row] == 0 then
      diagonal_column_start = position_data[:column]
      diagonal_row_start = position_data[:row]
    else
      if position_data[:column] < position_data[:row] then
        diagonal_column_start = (position_data[:row] - position_data[:column]) / 5
        diagonal_row_start = (position_data[:row] - position_data[:column]) + ((position_data[:row] - position_data[:column]) / 5)
      else
        diagonal_row_start = (position_data[:column] - position_data[:row]) / 5
        diagonal_column_start = (position_data[:column] - position_data[:row]) + ((position_data[:column] - position_data[:row]) / 5)
      end
    end

    # current
    diagonal_column = diagonal_column_start
    diagonal_row = diagonal_row_start

    until diagonal_column > 6 or diagonal_row > 5
      updated_diagonal_right.push(@memory[diagonal_column][diagonal_row])
      diagonal_column += 1
      diagonal_row += 1
    end

    @diagonal_right = updated_diagonal_right
    # dr_coor = {:start => "#{diagonal_col_start}#{diagonal_row_start}", :end => "#{diagonal_col}#{diagonal_row}"}
    # "#{dr_coor[:start]}#{dr_coor[:end]}"
  end

  def win?
    @search_data = [@column, @row, @diagonal_left, @diagonal_right]
    full_memory = []
    @search_data.each do |arr|
      arr.each do |slot|
        full_memory.push(slot)
      end
      full_memory.push("-")
    end
    
    consec_tokens = 0
    full_memory.each do |slot|
      (slot == @current_player.token) ? consec_tokens += 1 : consec_tokens = 0;
      return true if consec_tokens == 4
    end
    false
  end

  def tie?
    full_memory = []
    @memory.each {|arr| arr.each {|elem| full_memory.push(elem)}}

    return full_memory.find_index(" ").nil?
  end

  def play_again? 
    print "Do you want to play again? (y/n): "
    response = gets.chomp
    start if response == 'y'
    clear
    puts "Ended Game."
    exit
  end

  def clear
    system("clear")
  end

  def win_display
    clear
    update_board
    puts "#{@current_player.name} wins!"
    play_again?
  end

  def tie_display
    clear
    update_board
    puts "Tie Game!"
    play_again?
  end

  def change_current_player
    @current_player = (@current_player == @player_one) ? @player_two : @player_one
  end

  def play
    loop do
      selected_column = get_input
      p selected_column
      clear
      position_data = get_position_data(selected_column)
      set_row_data(position_data)
      set_diagonal_left_data(position_data)
      set_diagonal_right_data(position_data)
      # 1
      if win? == true then
        win_display
      else
        if tie? == true then
          tie_display
        end
      end
      update_board
      change_current_player
    end
  end

  def start
    new_board
    play
  end
end

game = ConnectFour.new
game.start