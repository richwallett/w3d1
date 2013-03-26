require 'board'
require 'rspec'


describe Board do
  subject(:board) {Board.new}
  let(:piece) {Piece.new(:black)}
  let (:first_four) {[3,4].product([4,3])}

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

  describe "#valid_moves" do
    it "requires that the center four pieces are used first" do
      board.valid_moves(:black).should be_eql first_four
    end
    it "returns 3 positions if one piece has been placed" do
      first_four.reject! { |position| position == [4,4]}
      board.place_piece(piece, [4,4])
      board.valid_moves(:black).should be_eql first_four
    end
    it "returns array of positions with flanking piece" do
      first_four.each { |position| board.place_piece(piece, position) }
      board.place_piece(Piece.new(:white), [2,2])
      board.valid_moves(:white).should be_eql [[5,5]]

    end
    it "returns an empty array if no valid moves" do
      first_four.each { |position| board.place_piece(piece, position) }
      board.valid_moves(:white).should be_empty
    end
  end

  describe "#flip_pieces" do
    it "flips all pieces between two positions" do
      board.place_piece(Piece.new(:white), [3,3])
      board.place_piece(Piece.new(:white), [4,4])
      board.place_piece(Piece.new(:black), [3,4])
      board.place_piece(Piece.new(:black), [4,3])
      board.place_piece(Piece.new(:black), [2,2])
      board.place_piece(Piece.new(:black), [5,5])
      board.flip_pieces([2,2], [5,5])
      2.upto(5).each {|n| board.piece_at([n,n]).should == :black}
    end
  end

  describe "#over?" do
    it "returns true if there are no available moves for either side" do
      first_four.each { |position| board.place_piece(piece, position) }
      board.over?.should be_true
    end
  end

  describe "#winner" do
    it "returns the color that has the most pieces on the board" do
      first_four.each { |position| board.place_piece(piece, position) }
      board.winner.should == :black
    end
    it "returns 'draw' if players have the same amount of pieces" do
      board.place_piece(Piece.new(:white), [3,3])
      board.place_piece(Piece.new(:white), [4,4])
      board.place_piece(Piece.new(:black), [3,4])
      board.place_piece(Piece.new(:black), [4,3])
      board.winner.should == :draw
    end
  end



end