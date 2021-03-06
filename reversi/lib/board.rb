require_relative 'piece'

class Board
  attr_reader :board, :vectors
  def initialize
    @board = make_board
    @vectors = [-1,0,1].product([-1,0,1]).reject {|position| position == [0,0]}
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
    if first_four_moves.empty?
      @vectors.each do |vector|
        flank = search_one_direction(position, vector, piece.color)
        next if flank.nil?
        flip_pieces(position, flank)
      end
    end
  end

  def piece_at(position)
    piece = @board[position[0]][position[1]]
    return nil if piece.nil?
    return piece.color
  end

  def pieces_of(color)
    pieces_of_color = []
    @board.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        position = [row_index, col_index]
        pieces_of_color << position if piece_at(position) == color
      end
    end
    pieces_of_color
  end

  def opp_color(color)
    color == :green ? :red : :green
  end

  def over?
    valid_moves(:red).empty? && valid_moves(:green).empty?
  end

  def flip_pieces(start, finish)
    @vectors.each do |vector|
      flank = search_one_direction(start, vector, piece_at(start))
      next if flank.nil?
      current_position = [start[0]+vector[0],start[1]+vector[1]]
      until current_position.eql?(flank)
        current_piece = @board[current_position[0]][current_position[1]]
        current_piece.flip_color unless current_piece.nil?
        current_position[0] += vector[0]
        current_position[1] += vector[1]
      end
    end
  end

  def first_four_moves
    [3,4].product([4,3]).select{ |el| piece_at(el).nil? }
  end

  def valid_moves(color)
    valid_moves = first_four_moves
    if valid_moves.empty?
      pieces_of(color).each do |position|
        vectors_of_interest = possible_flanks(position, color)
        vectors_of_interest.each do |vector|
          search = search_one_direction(position, vector, nil)
          valid_moves << search unless search.nil?
        end
      end
    end
    valid_moves.uniq
  end

  def possible_flanks(position,color)
    vectors_of_interest = []
    @vectors.each do |vector|
      adjacent = [position[0]+vector[0], position[1]+vector[1]]
      next if out_of_bounds?(adjacent)
      if piece_at(adjacent) == opp_color(color)
        until out_of_bounds?(adjacent) || piece_at(adjacent).nil? || piece_at(adjacent) == color
          adjacent[0] += vector[0]
          adjacent[1] += vector[1]
        end
        vectors_of_interest << vector if !out_of_bounds?(adjacent) && piece_at(adjacent).nil?
      end
    end
    vectors_of_interest
  end

  def search_one_direction(position, vector, color)
    current_position = [position[0]+vector[0],position[1]+vector[1]]
    until out_of_bounds?(current_position) || piece_at(current_position) == color
      current_position[0] += vector[0]
      current_position[1] += vector[1]
    end
    return nil if out_of_bounds?(current_position)
    return current_position if piece_at(current_position) == color
    nil
  end

  def winner
    case pieces_of(:green).length <=> pieces_of(:red).length
    when 1 then :green
    when -1 then :red
    when 0 then :draw
    end
  end

end

