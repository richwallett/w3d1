require 'rspec'
require 'hanoi'

describe Hanoi do
  subject(:hanoi) {Hanoi.new(5)}

  describe "#initialize" do
    its(:tower_one) {should have(5).discs}
    its(:tower_two) {should be_empty}
    its(:tower_three) {should be_empty}
  end

  describe "#move" do
    it "rejects if no discs on origin" do
      expect do
        hanoi.move(hanoi.tower_three, hanoi.tower_two)
      end.to raise_error("no discs to move")
    end
    it "should remove a disc from origin" do
      hanoi.move(hanoi.tower_one, hanoi.tower_two)
      hanoi.tower_one.length.should == 4
    end
    it "should move a disc to destination" do
      hanoi.move(hanoi.tower_one, hanoi.tower_two)
      hanoi.tower_two.length.should == 1
    end
    it "rejects moving a disc on top of a smaller disc" do
      hanoi.move(hanoi.tower_one, hanoi.tower_two)
      expect do
        hanoi.move(hanoi.tower_one, hanoi.tower_two)
      end.to raise_error("disc too large for tower")
    end
  end

  describe "#win?" do
    it "returns false if tower_one or tower_two still have discs" do
      hanoi.win?.should be_false
    end
    it "returns true if tower_one and tower_two are empty" do
      hanoi = Hanoi.new(1)
      hanoi.move(hanoi.tower_one, hanoi.tower_three)
      hanoi.win?.should be_true
    end
  end

  describe "#render" do
    it "displays 5 discs for tower 1" do
      hanoi = Hanoi.new(5)
      hanoi.render(hanoi.tower_one).should be_eql "5, 4, 3, 2, 1"
    end
  end
end