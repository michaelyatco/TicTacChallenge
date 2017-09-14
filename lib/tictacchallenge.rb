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
    (0..@size.pred).each_slice(@dimension).to_a +
    (0..@size.pred).each_slice(@dimension).to_a.transpose
  end

end
