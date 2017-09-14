require 'spec_helper'
require 'tictacchallenge'

describe Position do
  context "#new" do
    it "initializes a new board" do
      position = Position.new
      expect(position.board).to eq %w(- - -
                                      - - -
                                      - - -)
      expect(position.turn).to eq "x"
    end
    it "initializes a position give a board and turn" do
      position = Position.new(%w(- x -
                                 - - -
                                 - o -), "o")
      expect(position.board).to eq %w(- x -
                                      - - -
                                      - o -)
      expect(position.turn).to eq "o"
    end
  end
  context "#move" do
    it "makes a move" do
      position = Position.new.move(0)
      expect(position.board).to eq %w(x - -
                                      - - -
                                      - - -)
      expect(position.turn).to eq "o"
    end
  end
  context "#unmove" do
    it "undos a move" do
      position = Position.new.move(1).unmove
      init = Position.new
      expect(position.board).to eq init.board
      expect(position.turn).to eq init.turn
    end
  end
  context "#possible_moves" do
    it "lists possible moves for initial position" do
      expect(Position.new.possible_moves).to eq (0..8).to_a
    end
    it "lists possible moves for a position" do
      expect(Position.new.move(3).possible_moves).to eq [0,1,2,4,5,6,7,8]
    end
  end
  context "#winning_combo" do
    it "finds winning combination of row, columns, and diagonals" do
      winning_combo = Position.new(%w(0 1 2
                                      3 4 5
                                      6 7 8)).winning_combo
      expect(winning_combo).to include (["0","1","2"])
      expect(winning_combo).to include (["3","4","5"])
      expect(winning_combo).to include (["6","7","8"])
      expect(winning_combo).to include (["0","3","6"])
      expect(winning_combo).to include (["1","4","7"])
      expect(winning_combo).to include (["2","5","8"])
      expect(winning_combo).to include (["0","4","8"])
      expect(winning_combo).to include (["2","4","6"])
    end
  end
  context "#victory?" do
    it "determines no victory" do
      expect(Position.new.victory?("x")).to eq false
      expect(Position.new.victory?("o")).to eq false
    end
    it "determines victory for x" do
      expect(Position.new(%w(x x x
                             - - -
                             - o o)).victory?("x")).to eq true
    end
    it "determines victory for o" do
      expect(Position.new(%w(x x -
                             - - -
                             o o o)).victory?("o")).to eq true
    end
  end
  context "#blocked?" do
    it "determines not blocked" do
      expect(Position.new.blocked?).to eq false
    end
    it "determines blocked" do
      expect(Position.new(%w(x o x
                             o x o
                             o x o)).blocked?).to eq true
    end
  end
  context "#evaluate_leaf_node" do
    it "determines nothing from initial position" do
      expect(Position.new.evaluate_leaf_node).to eq nil
    end
    it "determines a victorious position for x" do
      expect(Position.new(%w(x - -
                             o x -
                             o - x)).evaluate_leaf_node).to eq 100
    end
    it "determines a victorious position for o" do
      expect(Position.new(%w(o x -
                             o x -
                             o - x), "o").evaluate_leaf_node).to eq -100
    end
    it "determines a blocked position" do
      expect(Position.new(%w(o x -
                             x x o
                             o o x), "x").evaluate_leaf_node).to eq 0
    end
  end
  context "#minimax" do
    it "determines an already victorious position" do
      expect(Position.new(%w(x x -
                             x o o
                             x o o)).minimax).to eq 100
    end
    it "determines a victory in 1 move for x" do
      expect(Position.new(%w(x x -
                             - o o
                             - - -), "x").minimax).to eq 99
    end
    it "determines a victory in 1 move for o" do
      expect(Position.new(%w(x x -
                             - o o
                             - - -), "o").minimax).to eq -99
    end
  end
  context "#best_move" do
    it "finds the winning move for x" do
      expect(Position.new(%w(x x -
                             - - -
                             o o -), "x").best_move).to eq 2
    end
    it "finds the winning move for o" do
      expect(Position.new(%w(x x -
                             - - -
                             o o -), "o").best_move).to eq 8
    end
  end
  context "#finished" do
    it "sees a position has not finished" do
      expect(Position.new.finished?).to eq false
    end
    it "sees a position has finished due to x's victory" do
      expect(Position.new(%w(x x x
                             - - -
                             o o -)).finished?).to eq true
    end
    it "sees a position has finished due to o's victory" do
      expect(Position.new(%w(x x -
                             - - -
                             o o o)).finished?).to eq true
    end
    it "sees a position has finished due to no more possible moves" do
      expect(Position.new(%w(x x o
                             o o x
                             x x o)).finished?).to eq true
    end
  end
end
