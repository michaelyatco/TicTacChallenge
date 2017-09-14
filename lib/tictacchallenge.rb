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

end
