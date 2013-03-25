require 'treenode'
require 'rspec'

describe TreeNode do
  subject(:treenode) {TreeNode.new(5)}

  describe "#initialize" do
    its(:value) {should == 5}
    its(:children) {should be_empty}
    its(:parent) {should be_nil}
  end

  describe "#add_child" do
    let (:first_child) { TreeNode.new(2) }
    it "adds child to children" do
      treenode.add_child(first_child)
      treenode.children[-1].should == first_child
    end
    it "sets child's parent to self" do
      treenode.add_child(first_child)
      first_child.parent.should == treenode
    end
  end

end
describe "tree search" do
  before(:each) do
    @nodes = []
    8.times { |value| @nodes << TreeNode.new(value) }
    @root = @nodes[0]
    @destination = @nodes[3]
    @nodes[0].add_child(@nodes[1])
    @nodes[0].add_child(@nodes[2])
    @nodes[1].add_child(@nodes[3])
    @nodes[1].add_child(@nodes[4])
    @nodes[2].add_child(@nodes[5])
    @nodes[2].add_child(@nodes[6])
    @nodes[3].add_child(@nodes[7])
    @nodes[6].add_child(TreeNode.new(5))
  end
  describe "#bfs" do
    it "finds node with provided value" do
      @nodes[1].should_receive(:value).ordered.and_call_original
      @nodes[2].should_receive(:value).ordered.and_call_original
      @nodes[3].should_receive(:value).ordered.and_call_original
      bfs(@root, 3).should == @destination
    end
  end
  describe "#dfs" do
    it "finds node with provided value" do
      @nodes[1].should_receive(:value).ordered.and_call_original
      @nodes[3].should_receive(:value).ordered.and_call_original
      dfs(@root, 3).should == @destination
    end
  end
end