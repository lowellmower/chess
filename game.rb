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
    @board = Board.new
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
    coordinate = "#{x},#{y}"
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

