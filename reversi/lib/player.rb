class Player
  attr_reader :color

  def initialize(board, color)
    @board, @color = board, color
  end

end