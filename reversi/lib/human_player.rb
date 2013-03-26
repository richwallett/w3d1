class HumanPlayer < Player
  LETTERS = ('a'..'h').to_a.map {|letter| letter.upcase }
  def take_turn
    puts "Possible moves (shown in blue): #{display_valid_moves}"
    puts "Where would you like to place a piece? ex. A5"
    input = gets.chomp
    converted_input = convert_input(input)
    until @board.valid_moves(@color).include?(converted_input)
      puts "Please enter a valid move"
      input = gets.chomp
      converted_input = convert_input(input)
    end
    converted_input
  end

  def display_valid_moves
    moves = @board.valid_moves(@color)
    moves.map! { |move| [LETTERS[move[1]],move[0]+1].join }
    moves.join(", ")
  end

  def convert_input(input)
    input_arr = input.split("")
    [input_arr[1].to_i-1, LETTERS.index(input_arr[0].upcase)]
  end

end
