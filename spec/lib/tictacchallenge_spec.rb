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
end
