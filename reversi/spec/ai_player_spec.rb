require 'rspec'
require 'player'
require 'board'

describe AIPlayer do
  #REV: You could use a double for the board rather then making
  #A new board object.
  let(:board) {Board.new}
  subject(:aiplayer) {AIPlayer.new(board, :green)}
  before(:each) do
    board.place_piece(Piece.new(:red), [3,3])
    board.place_piece(Piece.new(:red), [4,4])
    board.place_piece(Piece.new(:green), [3,4])
  end

  describe "#initialize" do
    it "knows what color it is" do
      aiplayer.color.should == :green
    end
  end

  describe "#take_turn" do
    it "should choose one of the 4 center squares if available" do
      aiplayer.take_turn.should == [4,3]
    end
    it "should choose the move that flips the most pieces" do
      board.place_piece(Piece.new(:green), [4,3])
      board.place_piece(Piece.new(:green), [2,2])
      aiplayer.take_turn.should == [5,5]
    end
  end

end