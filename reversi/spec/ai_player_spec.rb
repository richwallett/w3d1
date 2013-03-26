require 'rspec'
require 'ai_player'
require 'reversi'

describe AIPlayer do
  let(:board) {Board.new}
  subject(:aiplayer) {AIPlayer.new(board, :black)}
  before(:each) do
    board.place_piece(Piece.new(:white), [3,3])
    board.place_piece(Piece.new(:white), [4,4])
    board.place_piece(Piece.new(:black), [3,4])
    board.place_piece(Piece.new(:black), [4,3])
    board.place_piece(Piece.new(:black), [2,2])
  end

  describe "#initialize" do
    it "knows what color it is" do
      aiplayer.color.should == :black
    end
  end

end