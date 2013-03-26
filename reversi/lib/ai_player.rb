require_relative 'player'

class AIPlayer < Player

  def take_turn
    ai_moves = @board.valid_moves(@color)
    best_score = 0
    best_move = nil
    first_four = @board.first_four_moves
    return first_four.sample unless first_four.empty?
    ai_moves.each do |move|
      current_score = 0
      @board.vectors.each do |vector|
        possible_move = @board.search_one_direction(move, vector, @color)
        next if possible_move.nil?
        if possible_move[0] == move[0]
          score = (possible_move[1] - move[1])
        else
          score = (possible_move[0] - move[0])
        end
        current_score += score.abs - 1
        if current_score >= best_score
          best_score = current_score
          best_move = move
        end
      end
    end
    p "#{best_move} is the best move"
    best_move
  end

end