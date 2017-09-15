class Position
  attr_accessor :board, :turn

  def initialize board=nil, turn="x"
    @dimension = 3
    @size = @dimension * @dimension
    @board = board || Array.new(@size, "-")
    @turn = turn
    @movelist = []
  end

  def move index
    @board[index] = @turn
    @turn = other_turn
    @movelist << index
    self
  end

  def other_turn
    @turn == "x" ? "o" : "x"
  end

  def unmove
    @board[@movelist.pop] = "-"
    @turn = other_turn
    self
  end

  def possible_moves
    @board.map.with_index { |piece, index| piece == "-" ? index : nil }.compact
  end

  def winning_combo
    (
      (0..@size.pred).each_slice(@dimension).to_a +
      (0..@size.pred).each_slice(@dimension).to_a.transpose +
      [ (0..@size.pred).step(@dimension.succ).to_a] +
      [ (@dimension.pred..(@size-@dimension)).step(@dimension.pred).to_a]
    ).map {|combo| combo.map {|index| @board[index] }}
  end

  def victory? piece
    winning_combo.any? { |combo|
      combo.all? { |combo_piece| combo_piece == piece }
    }
  end

  def blocked?
    winning_combo.all? { |combo|
      combo.any? { |combo_piece| combo_piece == "x" } &&
      combo.any? { |combo_piece| combo_piece == "o" }
    }
  end

  def evaluate_leaf_node
    return 100 if victory?("x")
    return -100 if victory?("o")
    return 0 if blocked?
  end

  def minimax index=nil
    move(index) if index
    leaf_node_value = evaluate_leaf_node
    return leaf_node_value if leaf_node_value
    possible_moves.map { |index|
      minimax(index).send(@turn == "x" ? :- : :+, @movelist.count+1)
    }.send(@turn == "x" ? :max : :min)
  ensure
    unmove if index
  end

  def best_move
    possible_moves.send(@turn == "x" ? :max_by : :min_by) {|index| minimax(index) }
  end

  def finished?
    victory?("x") || victory?("o") || @board.count("-") == 0
  end

  def to_s
    @board.each_slice(@dimension).map { |line|
      " " + line.map {|piece| piece == "-" ? " " : piece}.join(" | ") + " "
    }.join("\n-----------\n") + "\n"
  end
end

class TicTacToe

  def determine_player
    puts "\nWelcome to my TicTacToe Challenge!"
    puts "Instructions:"
    puts "~Decide whether you or the computer will go first."
    puts "~When the round begins, your choices are the numbers [0-8]."
    puts "~Each number represents one of the nine spaces within the grid."
    puts "~Starting in the top-left corner and moving right, the numbers are assigned to each space as you move through the grid."
    puts "~0 represents the top-left corner, 1 the top-middle space, 2 the top right corner for the top row."
    puts "~3 represents the middle-left space, 4 the middle space, and 5 the middle-right space for the middle row."
    puts "~6 represents the top-left corner, 7 the top-middle space, 8 the top right corner for the top row."
    puts "\n~Ok! Let's start!~"
    puts "\nWho will go first? Enter the number only:"
    puts "1. The Human"
    puts "2. The Computer"
    while true
      print "choice: "
      answer = gets.chomp
      return "human" if answer == "1"
      return "computer" if answer == "2"
    end
  end

  def request_move position
    while true
      print "move: "
      answer = gets.chomp
        if answer =~ /^\d+$/ && position.board[answer.to_i] == "-"
          return answer.to_i
        else
          puts "Please choose a valid move:"
        end
    end
  end

  def other_player
    @player == "human" ? "computer" : "human"
  end

  def play_round
    @player = determine_player
    position = Position.new
    while !position.finished?
      puts position
      @player == "human" ? puts("Your turn, human!") : puts("I'm thinking...")
      puts
      index = @player == "human" ? request_move(position) : position.best_move
      position.move(index)
      @player = other_player
    end
    puts position
    if position.blocked?
      puts "Draw!"
    else
      puts "Winner - the #{other_player}!"
    end
    puts "\nPlay another round? y/n"
    answer = gets
    if answer.downcase.strip == 'y'
      position = TicTacToe.new.play_round
      determine_player
    else
      puts "\nTake care! Thanks for playing!"
      exit
    end
  end
end

if __FILE__ == $0
  TicTacToe.new.play_round
end
