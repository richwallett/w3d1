require 'reversi'
require 'rspec'


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
