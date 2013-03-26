require 'piece'
require 'rspec'


describe Piece do
  subject(:piece) {Piece.new(:green)}
  describe "#initialize" do
    its(:color) {should == :green}
  end

  describe "#flip_color" do
    it "flips color when called" do
      piece.color.should == :green
      piece.flip_color
      piece.color.should == :red
      piece.flip_color
      piece.color.should == :green
    end
  end
end
