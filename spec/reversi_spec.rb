require 'reversi'
require 'rspec'

describe Board do
  subject(:board) {Board.new}

  describe "#initialize" do
    it "initializes the board" do
      board.should_receive(:make_board)
      board.make_board
    end
  end
end

describe Piece do
end

describe Game do
end
