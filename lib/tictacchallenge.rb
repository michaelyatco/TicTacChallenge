class Position
  attr_accessor :board, :turn

  def initialize board=nil, turn="x"
    @dimension = 3
    @size = @dimension * @dimension
    @board = board || Array.new(@size, "-")
    @turn = turn
  end

  def move index
    @board[index] = @turn
    @turn = other_turn
    self
  end

  def other_turn
    @turn == "x" ? "o" : "x"
  end

end
