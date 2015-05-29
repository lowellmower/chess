require_relative 'piece'

# class Bishop < Piece
  # def how_can_i_move(x,y)
    x = 5
    y = 3
    n = 1
    possible_array = []
     while n < 8
      directions = [[x-n, y-n], [x-n, y+n], [x+n, y-n], [x+n, y +n]]
      directions.each do |direction|
      possible_array << direction unless direction[0] <0 || direction[0] > 7 || direction[1] < 0 || direction[1] > 7
      end
      n += 1
    end
p possible_array
  # end
# end

