class Board
  attr_reader :board
  def initialize
    @board = make_board
  end

  def make_board
    Array.new(8) { Array.new(8) }
  end
  def place_piece(piece, position)
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