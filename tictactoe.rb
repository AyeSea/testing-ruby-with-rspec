class Player
  attr_reader :name, :mark, :box

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def select_box
    puts "#{name}, please select a box (1 - 9):"
    @box = gets.chomp.to_i
  end
end

class Board
  attr_reader :current_board, :win_combos

  def initialize
    @win_combos = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9],
      [1, 4, 7], [2, 5, 8], [3, 6, 9],
      [1, 5, 9], [3, 5, 7]
   ]
    @current_board = {}
    create_board
  end

  def show_board
    i = 0
    3.times do
      3.times do 
        i += 1
        print "| #{current_board[i]} |"
      end
      puts "\n_______________" if i == 3 || i == 6
    end
  end

  def update_box(box_key, mark)
      current_board[box_key] = mark
  end

  def box_empty?(box_key)
    current_board[box_key] == '-' ? true : false
  end

  private
  def create_board
    9.times do |i|
      current_board[i + 1] = "-"
    end
  end
end

class TicTacToe
  attr_reader :player1, :player2, :board, :box_key

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
  end

  def begin
    game_description

    loop do 
      player_turn(player1)
      player_turn(player2)
    end
  end

  private
  def game_description
    puts "\nEach box on the board is represented with a number from 1 - 9,"
    puts "where the box in the top-left corner is 1 and the one in the bottom-right corner is 9."
    puts "Think of how numbers are displayed on a typical phonepad.\n"
  end

  def player_turn(playernum)
    puts "#{playernum.name}'s turn."

    #Loop until win or draw conditions are met.
    loop do 
      puts "Please select a box:"
      @box_key = gets.chomp.to_i
       
      if (1..9).include?(box_key)
        if board.box_empty?(box_key)
          board.update_box(box_key, playernum.mark)
          break
        else
          puts "Box #{box_key} is already taken. Please try again."
        end
      else
        puts "Box #{box_key} is not a valid box. Please try again."
      end
    end

    board.show_board
    puts
    if victory?(playernum)
      puts "#{playernum.name} wins!"
      exit
    elsif draw?
      puts "Tie Game!"
      exit
    end
  end

  def victory?(playernum)
    @board.win_combos.each do |win_combo|
      matches = win_combo.select { |cell| @board.current_board[cell] == playernum.mark }
      return true if matches.size == 3
    end

    false
  end

  def draw?
    board.current_board.each do |box_key, box_value|
      return false if box_value == '-'
    end
    true
  end
end