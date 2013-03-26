require_relative 'board'
require_relative 'player'
require_relative 'piece'
require 'colorize'

class Game
  def initialize(red = :human, green = :human)
    @board = Board.new
    @red_player = setup_player(red, :red)
    @green_player = setup_player(green, :green)
  end

  def setup_player(type, color)
    case type
    when :human then HumanPlayer.new(@board, color)
    when :ai then AIPlayer.new(@board, color)
    end
  end

  def play
    @turn = :red
    until @board.over?
      print_board
      puts "#{@turn.capitalize} player's turn:"
      if @board.valid_moves(@turn).empty?
        puts "No valid moves for #{@turn} player."
      else
        move = take_turn
        @board.place_piece(Piece.new(@turn), move)
      end
      @turn = @board.opp_color(@turn)
    end
    print_winner(@board.winner)
    print_board
  end

  def print_winner(winner)
    if winner == :draw
      puts "Draw."
    else
      puts "#{winner.capitalize} player wins."
    end
  end

  def print_board
    possible_moves = @board.valid_moves(@turn) unless @board.over?
    print "    "
    puts ('a'..'h').to_a.join('  ')
    8.times do |row|
      print "#{row+1} "
      8.times do |col|
        square = @board.board[row][col]
        if square.nil?
          if !possible_moves.nil? && possible_moves.include?([row,col])
            print " \u263B ".blue.blink
          else
            print "   "
          end
        else
          print " \u263B ".green if square.color == :green
          print " \u263B ".red if square.color == :red
        end
      end
      case row
      when 0 then print "  Score:"
      when 1 then print "  Red: #{@board.pieces_of(:red).length}".red
      when 2 then print "  Green: #{@board.pieces_of(:green).length}".green
      end
      puts
    end
  end

  def take_turn
    case @turn
    when :red then @red_player.take_turn
    when :green then @green_player.take_turn
    end
  end
end

game = Game.new
game.play