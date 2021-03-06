require 'reversi'
require 'rspec'

describe Game do
  subject(:game) {Game.new}
  let(:piece) {Piece.new(:red)}

  describe "#take_turn" do
    it "raises error if invalid move" do
      expect do
        @board.place_piece(piece, [2,2])
      end.to raise_error("not a valid move")
    end
  end


end
