class Game
  attr_accessor :player_one_name, :player_two_name, :user_number, :turn
  attr_reader :player_one_moves, :player_two_moves, :win_conditions, :is_over, :stop_game
  def initialize(player_one_name, player_two_name)
    @player_one_name = player_one_name
    @player_two_name = player_two_name
    @player_one_moves = []
    @player_two_moves = []
    @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @user_number = 0
    @win_conditions = [
      [0, 1, 2],
      [0, 3, 6],
      [0, 4, 8],
      [1, 4, 7],
      [2, 5, 8],
      [2, 4, 6],
      [3, 4, 5],
      [6, 7, 8]
    ]
    @user_availability = [
      "Top Left",
      "Top Center",
      "Top Right",
      "Middle Left",
      "Middle Center",
      "Middle Right",
      "Bottom Left",
      "Bottom Center",
      "Bottom Right"
    ]
    @is_over = false
    @turn = true
    @stop_game = false
    @player_one_score = 0
    @player_two_score = 0
  end

  def display_board
  puts [" #{@board[0]} " "|" " #{@board[1]} " "|" " #{@board[2]} "]
  puts seperator = "-----------"
  puts [" #{@board[3]} " "|" " #{@board[4]} " "|" " #{@board[5]} "]
  puts seperator
  puts [" #{@board[6]} " "|" " #{@board[7]} " "|" " #{@board[8]} "]
  end

  def check_if_available
    if @board[@user_number] != " "
      return false
    else
      return true
    end
  end

  def move
    if @turn
      @board[user_number] = "X"
      player_one_moves.push(user_number)
    else
      @board[user_number] = "O"
      player_two_moves.push(user_number)
    end
  end

  def win_check
    win_conditions.each do |condition|
      if @turn
        how_won = condition - player_one_moves
        if how_won.empty?
          system("clear")
          puts "Player 1 wins"
          @player_one_score += 1
          return @is_over = true
        end
      else
        how_won = condition - player_two_moves
        if how_won.empty?
          system("clear")
          puts "Player 2 wins"
          @player_two_score += 1
          return @is_over = true
        end
      end
    end
    @turn = !@turn
  end

  def draw_check
    draw = player_one_moves + player_two_moves
    if draw.length == 9 && @is_over == false
      system("clear")
      puts "It is a draw"
      @is_over = true
    end
  end

  def user_input
    puts "\nWhere would you like to go #{@turn? player_one_name: player_two_name}?"
    @board.each_with_index do |tile, index|
      if tile == " "
        puts "#{@user_availability[index]}: #{index + 1}"
      end
    end
    @user_number = gets.chomp.to_i - 1
    if @user_number == -1
      @user_number = 10
    end
  end

  def whose_turn
    if @turn
      puts "#{player_one_name}'s Turn"
    else
      puts "#{player_two_name}'s Turn"
    end
  end
  def score_board
    puts "#{player_one_name}: #{@player_one_score}"
    puts ""
    puts "#{player_two_name}: #{@player_two_score}"
    puts ""
  end

  def end_game
    puts 'Would you like to continue playing the game? [Yes, No]'
    user_response = gets.chomp.downcase
    if user_response == "no" || user_response == 'n'
      @stop_game = true
    else
      @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      @player_one_moves = []
      @player_two_moves = []
      @is_over = false
      @turn = true
      @stop_game = false
    end
  end
end

puts "Player 1 enter your name"
player_one_name = gets.chomp
if player_one_name.empty?
  player_one_name = "Player 1"
end
puts "#{player_one_name} Ready"

puts "Player 2 enter your name"
player_two_name = gets.chomp
if player_two_name.empty?
  player_two_name = "Player 2"
end
puts "#{player_two_name} Ready"

game = Game.new(player_one_name, player_two_name)
# puts game.display_board
while game.stop_game == false
  system("clear")
  game.score_board
  game.whose_turn
  game.display_board
  game.user_input
  if game.check_if_available
    game.move
    game.win_check
    game.draw_check
  end
  if game.is_over == true
    game.display_board
    game.end_game
  end
end
