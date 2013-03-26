class AIPlayer
  attr_reader :color
  def initialize(board, color)
    @board, @color = board, color
  end

  def take_turn
    ai_moves = @board.valid_moves(color)
  end

end