require_relative 'board'
require_relative 'player'
require_relative 'human_player'
require_relative 'piece'

class Game
  def initialize(white = :ai, black = :ai)
    @board = Board.new
    @white_player = setup_player(white, :white)
    @black_player = setup_player(black, :black)
  end

  def setup_player(type, color)
    case type
    when :human then HumanPlayer.new(@board, color)
    when :ai then AIPlayer.new(@board, color)
    end
  end

  def play
    turn = :white
    until @board.over?
      print_board
      puts "#{turn.capitalize} player's turn:"
      if @board.valid_moves(turn).empty?
        puts "No valid moves for #{turn} player."
      else
        move = take_turn(turn)
        @board.place_piece(Piece.new(turn), move)
      end
      turn = @board.opp_color(turn)
    end
    print_winner(@board.winner)
  end

  def print_winner(winner)
    if winner == :draw
      puts "Draw."
    else
      puts "#{winner.capitalize} player wins."
    end
  end

  def print_board
    print "   "
    puts ('a'..'h').to_a.join('  ')
    8.times do |row|
      print "#{row+1} "
      8.times do |col|
        square = @board.board[row][col]
        if square.nil?
          print "   "
        else
          print " X " if square.color == :black
          print " O " if square.color == :white
        end
      end
      puts
    end
  end

  def take_turn(turn)
    case turn
    when :white then @white_player.take_turn
    when :black then @black_player.take_turn
    end
  end
end

game = Game.new
game.play