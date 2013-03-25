class TreeNode
  attr_reader :children, :value
  attr_accessor :parent
  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end

  def add_child(child)
    @children << child
    child.parent = self
  end
end

def bfs(start, value)
  queue = [start]
  until queue.empty?
    current = queue.shift
    return current if current.value == value
    queue += current.children
  end
  nil
end

def dfs(start, value)
  current = start
  return current if current.value == value
  current.children.each do |child|
    result = dfs(child, value)
    return result unless result.nil?
  end
  nil
end