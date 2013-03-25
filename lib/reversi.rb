class Board
  attr_reader :board
  def initialize
    @board = make_board
  end

  def make_board
    Array.new(8) { Array.new(8) }
  end

  def out_of_bounds?(position)
    position[0] < 0 || position[0] > 7 || position[1] < 0 || position[1] > 7
  end

  def place_piece(piece, position)
    raise "Out of bounds." if out_of_bounds?(position)
    @board[position[0]][position[1]] = piece
  end
  def piece_at(position)
    piece = @board[position[0]][position[1]]
    return nil if piece.nil?
    return piece.color
  end
end

class Piece
end

class Game
end