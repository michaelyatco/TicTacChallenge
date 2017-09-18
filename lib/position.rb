module TicTacToe
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
end
