require './board'

class Game
  def initialize(white_player, black_player)
    @board = Board.new
    @white_player = white_player
    @black_player = black_player
  end

  def play
    turn = :white
    until @board.over?
      print_board
      take_turn(turn)
      turn = @board.opp_color(turn)
    end
  end

end

