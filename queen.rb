require_relative 'piece'

class Queen < Piece
  def how_can_i_move(xy)
    x = split_coordinate(xy)[0]
    y = split_coordinate(xy)[1]
    n = 1
    possible_array = []
    ul = []
    ll = []
    ur = []
    lr = []
    up = []
    down = []
    left = []
    right = []
    while n < 8
    direction = [[x-n, y-n],[x-n, y+n],[x+n, y-n], [x+n, y +n], [x-n, y],[x+n, y],[x, y-n], [x, y +n]]
     ul    << direction[0] unless direction[0][0] <0 || direction[0][0] > 7 || direction[0][1] < 0 || direction[0][1] > 7
     ll    << direction[1] unless direction[1][0] <0 || direction[1][0] > 7 || direction[1][1] < 0 || direction[1][1] > 7
     ur    << direction[2] unless direction[2][0] <0 || direction[2][0] > 7 || direction[2][1] < 0 || direction[2][1] > 7
     lr    << direction[3] unless direction[3][0] <0 || direction[3][0] > 7 || direction[3][1] < 0 || direction[3][1] > 7
     up    << direction[4] unless direction[4][0] <0 || direction[4][0] > 7 || direction[4][1] < 0 || direction[4][1] > 7
     down  << direction[5] unless direction[5][0] <0 || direction[5][0] > 7 || direction[5][1] < 0 || direction[5][1] > 7
     left  << direction[6] unless direction[6][0] <0 || direction[6][0] > 7 || direction[6][1] < 0 || direction[6][1] > 7
     right << direction[7] unless direction[7][0] <0 || direction[7][0] > 7 || direction[7][1] < 0 || direction[7][1] > 7
     n += 1
    end
    possible_array << ul << ll << ur << lr << up << down << left << right
    possible_array.delete([])
    possible_array
  end
end
