class Piece
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def flip_color
    @color = (@color == :black ? :white : :black)
  end
end
