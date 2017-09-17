require_relative "./position"

class TicTacToe

  def determine_player
    puts "\nWelcome to my TicTacToe Challenge!"
    puts "Instructions:"
    puts "~Decide whether you or the computer will go first."
    puts "~When the round begins, your choices are the numbers [0-8]."
    puts "~Each number represents one of the nine spaces within the grid."
    puts "~Starting in the top-left corner and moving right, the numbers are assigned to each space as you move through the grid."
    puts "~0 represents the top-left corner, 1 the top-middle space, 2 the top-right corner for the top row."
    puts "~3 represents the middle-left space, 4 the middle space, and 5 the middle-right space for the middle row."
    puts "~6 represents the bottom-left corner, 7 the bottom-middle space, 8 the bottom-right corner for the bottom row."
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
