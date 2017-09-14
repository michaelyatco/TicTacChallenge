require 'spec_helper'
require 'tictacchallenge'

describe Position do
  context "#new" do
    it "should initialize a new board" do
      position = Position.new
      expect(position.board).to eq %w(- - -
                                      - - -
                                      - - -)
      expect(position.turn).to eq "x"
    end
  end
end
