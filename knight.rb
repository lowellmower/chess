require_relative 'piece'cb
]
class Knight < Piece
#move list method will take an index from the board and generate an array of possible moves based on its current position.

  # def how_can_i_move(x,y)
   @possible_moves = [[x - 2, y - 1], [x - 2, y + 1], [x + 2, y - 1], [x + 2, y + 1], [x-1, y-2], [x-1, y +2], [x+1, y-2], [x+1, y +2]]

  # end
end


