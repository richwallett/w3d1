require 'reversi'
require 'rspec'

describe Board do
  subject(:board) {Board.new}
  let(:piece) {double("Piece", :color => :black)}
  describe "#make_board" do
    it "creates an 8x8 array" do
      board.board.each do |el|
        el.length.should == 8
      end
      board.board.length.should == 8
    end
  end
  describe "#place_piece" do
    it "places a piece at given location" do
      board.place_piece(piece, [0,0])
      board.board[0][0].should == piece
    end
  end
  describe "#piece_at" do
    it "returns nil if no piece" do
      board.piece_at([0,0]).should be_nil
    end
    it "returns color of piece if piece present" do
      board.place_piece(piece, [0,0])
      board.piece_at([0,0]).should == :black
    end
  end
end

describe Piece do
end

describe Game do
end
