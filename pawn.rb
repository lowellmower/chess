require_relative 'piece'
# require 'pry'

class Pawn < Piece
  attr_accessor :first_move, :captured
  attr_reader :color
  def initialize(color = "black")
    @captured = false
    @color = color
    @first_move = true
  end

  def how_can_i_move(xy)
    x = split_coordinate(xy)[0]
    y = split_coordinate(xy)[1]
      if first_move == true && color == "black"
        possible_moves = [[x+1, y], [x+2, y],[x+1,  y+1],[x+1,  y-1]]
        possible_moves.delete_if {|coord| coord[0] < 0 || coord[0] > 7 || coord[1] < 0 || coord[1] > 7}
        self.first_move = false
        possible_moves
      elsif first_move == true && color == "white"
        possible_moves = [[x-1, y], [x-2, y],[x-1,  y+1],[x-1,  y-1]]
        possible_moves.delete_if {|coord| coord[0] < 0 || coord[0] > 7 || coord[1] < 0 || coord[1] > 7}
        self.first_move = false
        possible_moves
      elsif first_move == false && color == "black"
        possible_moves = [[x+1, y], [x+1,  y+1],[x+1,  y-1]]
        possible_moves.delete_if {|coord| coord[0] < 0 || coord[0] > 7 || coord[1] < 0 || coord[1] > 7}
        possible_moves
      elsif first_move == false && color == "white"
        possible_moves = [[x-1, y], [x-1,  y+1],[x-1,  y-1]]
        possible_moves.delete_if {|coord| coord[0] < 0 || coord[0] > 7 || coord[1] < 0 || coord[1] > 7}
        possible_moves
      end
  end
end
