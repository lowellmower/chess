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
  #------------------------get started-----------------------------------
  def initialize
    @board_string = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"
    @board = Board.new(@board_string)
    #run the view method to show the board
    run
  end


  def run
    #until @board.game_over
      View.welcome_message
      View.display(@board_string)
      View.white_move
      users_input = View.get_input
      converted = convert_to_coord(users_input) #0,0
      array_of_moves = @board.eligible_moves_bcq(converted) #[[2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
      array_into_position = coord_to_position(array_of_moves) #["A6", "A5", "A4", "A3", "A2", "A1"]
      View.moves_for_white(users_input, array_into_position)
      users_input2 = View.get_input

  #end

end


 #--------------------who's turn is it?----------------------------------
  # def colors(player1 = "black", player2 = "white")
  #   @player1 = player1
  #   @player2 = player2
  #   if @player == player1
  #     "#{@player1.capitalize} Player"
  #   else
  #     "#{@player2.capitalize} Player"
  # end

  # def toggle_turn
  #   if @player == @player1
  #     @player = @player2
  #   else
  #     @player1
  #   end
  # end

  # def run
  # end
#----------------------let's get/give some info--------------------------

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


