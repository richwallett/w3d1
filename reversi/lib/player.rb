class Player
  attr_reader :color

  def initialize(board, color)
    @board, @color = board, color
  end

end

class AIPlayer < Player

  def take_turn
    ai_moves = @board.valid_moves(@color)
    first_four = @board.first_four_moves
    return first_four.sample unless first_four.empty?
    best_score = 0
    best_move = nil
    ai_moves.each do |move|
      @board.vectors.each do |vector|
        current_score = flips_one_way(move,vector)
        if current_score >= best_score
          best_score = current_score
          best_move = move
        end
      end
    end
    best_move
  end

  def flips_one_way(move, vector)
    current_score = 0
    possible_move = @board.search_one_direction(move, vector, @color)
    return -1 if possible_move.nil?
    if possible_move[0] == move[0]
      score = (possible_move[1] - move[1])
    else
      score = (possible_move[0] - move[0])
    end
    current_score += score.abs - 1
  end
end

class HumanPlayer < Player
  LETTERS = ('a'..'h').to_a.map {|letter| letter.upcase }
  def take_turn
    puts "Where would you like to place a piece? ex. A5"
    puts "Possible moves are shown in blue."
    converted_input = convert_input(gets.chomp)
    until @board.valid_moves(@color).include?(converted_input)
      puts "Please enter a valid move"
      converted_input = convert_input(gets.chomp)
    end
    converted_input
  end

  def convert_input(input)
    input_arr = input.split("")
    [input_arr[1].to_i-1, LETTERS.index(input_arr[0].upcase)]
  end

end
