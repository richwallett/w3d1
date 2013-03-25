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
    it "does not allow moves outside of the board" do
      expect do
        board.place_piece(piece, [9,9])
      end.to raise_error("Out of bounds.")
    end
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

  describe "#valid_move?" do
    it "requires that the center four pieces are used first" do
      first_four = [3,4].product([4,3])
      board.valid_moves.should be_eql first_four
    end
  end

end

describe Piece do
  subject(:piece) {Piece.new(:black)}
  describe "#initialize" do
    its(:color) {should == :black}
  end

  describe "#flip_color" do
    it "flips color when called" do
      piece.color.should == :black
      piece.flip_color
      piece.color.should == :white
      piece.flip_color
      piece.color.should == :black
    end
  end
end

describe Game do
end
