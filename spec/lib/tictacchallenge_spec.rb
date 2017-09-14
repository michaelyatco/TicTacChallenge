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
  context "winning_combo" do
    it "finds winning combination of row, columns, and diagonals" do
      winning_combo = Position.new.winning_combo
      expect(winning_combo).to include [0,1,2]
      expect(winning_combo).to include [3,4,5]
      expect(winning_combo).to include [6,7,8]
      expect(winning_combo).to include [0,3,6]
      expect(winning_combo).to include [1,4,7]
      expect(winning_combo).to include [2,5,8]
      expect(winning_combo).to include [0,4,8]
      expect(winning_combo).to include [2,4,6]
    end
  end
end
