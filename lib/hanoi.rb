#REV: Nice clean code, easy to read. I like how you parameterized the number of discs
class Hanoi
  attr_reader :tower_one, :tower_two, :tower_three
  def initialize(discs)
    @tower_one = (1..discs).to_a.reverse
    @tower_two = []
    @tower_three = []
  end

  def move(origin, destination)
    raise "no discs to move" if origin.empty?
    if !destination.empty? && destination[-1] < origin[-1]
      raise "disc too large for tower"
    end
    popped_disc = origin.pop
    destination << popped_disc
  end

  def win?
    @tower_one.empty? && @tower_two.empty? ? true : false
  end

  def render(tower)
    tower.join(", ")
  end
end
