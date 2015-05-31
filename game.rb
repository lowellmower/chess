require 'pry'
require_relative "board"
require_relative "view"

class Game
  HASH = {
    "A" => 0,
    "B" => 1,
    "C" => 2,
    "D" => 3,
    "E" => 4,
    "F" => 5,
    "G" => 6,
    "H" => 7
  }

  def initialize
    @board = Board.new
    run
  end

  def run
    View.welcome_message
    until @board.captured_pieces.length == 4
      View.display(@board.display)
      View.white_move
      users_input_1 = View.get_input
      converted = convert_to_coord(users_input_1)
      positions = coord_to_position(@board.call_for_moves(converted))
      View.moves_for_white(users_input_1, positions)
      converted_2 = convert_to_coord(View.get_input)
      @board.move(converted, converted_2)
      @board.reset_screen!
      View.display(@board.display)
      # black turn
      View.black_move
      users_input_1 = View.get_input
      converted = convert_to_coord(users_input_1)
      positions = coord_to_position(@board.call_for_moves(converted))
      View.moves_for_white(users_input_1, positions)
      converted_2 = convert_to_coord(View.get_input)
      @board.move(converted, converted_2)
      View.display(@board.display)
      @board.reset_screen!
    end
  end

  def convert_to_coord(position)
    position = position.split("")
    @x = 8 - position[1].to_i
    @y = HASH[position[0].upcase]
    coordinate = "#{@x},#{@y}"
  end

  def coord_to_position(eligible_moves)
    result = []
    eligible_moves.flatten.map.each_slice(2){|pair| result << pair }
    result.map do |coord|
      x = 8 - coord[0]
      y = HASH.key(coord[1])
      "#{y}#{x}"
    end
  end
end

gary = Game.new


