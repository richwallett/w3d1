require_relative 'board'
require_relative 'player'
require_relative 'piece'
require 'colorize'
LETTERS = ["\u24B6", "\u24B7", "\u24B8", "\u24B9",
           "\u24BA", "\u24BB", "\u24BC", "\u24BD"]
NUMBERS = ["\u2460", "\u2461", "\u2462", "\u2463",
           "\u2464", "\u2465", "\u2466", "\u2467"]
class Game
  def initialize(red = :human, green = :human)
    @board = Board.new
    @turn = :red
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
    until @board.over?
      print_board
      print "          "
      puts "#{@turn.to_s.capitalize.colorize(:color => @turn)} player's turn"
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

  def print_board #REV: I don't know what the hell
    system("clear") #REV: half of this is but I bet it's pretty
    possible_moves = @board.valid_moves(@turn) unless @board.over?
    print_border_letters
    8.times do |row|
      print " #{NUMBERS[row]} ".colorize(:color => :cyan, :background => :black)
      8.times do |col|
        square = @board.board[row][col]
        background = (row+col).odd? ? :light_blue : :blue
        if square.nil?
          if !possible_moves.nil? && possible_moves.include?([row,col])
            print " \u263B  ".yellow.blink.colorize(:background => background)
          else
            print "    ".colorize(:background => background)
          end
        else
          print " \u263B  ".colorize(:color => square.color, :background => background)
        end
      end
      print_scoreboard(row)
    end
  end
  def print_border_letters
    print "    ".colorize(:background => :black)
    print LETTERS.join('   ').colorize(:color => :cyan, :background => :black)
    puts "  ".colorize(:color => :cyan, :background => :black)
  end
  def print_scoreboard(row) #REV: wow
      case row
      when 0 then print " " + " Score:".ljust(12).on_blue
      when 1 then print " " + " Red: #{@board.pieces_of(:red).length}".ljust(12).on_red
      when 2 then print " " + " Green: #{@board.pieces_of(:green).length}".ljust(12).on_green
      end
      puts
  end
  def take_turn
    case @turn
    when :red then move = @red_player.take_turn
    when :green then move = @green_player.take_turn
    end
    move
  end
end

game = Game.new
game.play