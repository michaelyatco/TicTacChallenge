class Position
  attr_accessor :board, :turn
  def initialize
    @dimension = 3
    @size = @dimension * @dimension
    @board = Array.new(@size, "-")
    @turn = "x"
  end
end
