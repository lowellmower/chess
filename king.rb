
require_relative 'piece'

class King < Piece
  def how_can_i_move(xy)
   x = split_coordinate(xy)[0]
   y = split_coordinate(xy)[1]
   possible_moves = [[x - 1, y - 1],
                     [x + 1, y + 1],
                     [x + 1, y - 1],
                     [x - 1, y + 1],
                     [x , y + 1],
                     [x , y - 1],
                     [x - 1, y ],
                     [x + 1, y ]
                     ]
   possible_moves.delete_if {|coord| coord[0] < 0 || coord[0] > 7 || coord[1] < 0 || coord[1] > 7}
  end
end

