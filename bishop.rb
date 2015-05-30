require_relative 'piece'

class Bishop < Piece
  attr_accessor :captured, :color
  attr_reader :color, :picture
  def initialize(color = "black")
    @captured = false
    @color = color
    if self.color == "black"
      @picture = "♝"
    else
      @picture = "♗"
    end
  end

  def how_can_i_move(xy)
    x = split_coordinate(xy)[0]
    y = split_coordinate(xy)[1]
    n = 1
    possible_array = []
    ul = []
    ll = []
    ur = []
    lr = []
    while n < 8
    direction = [[x-n, y-n],[x-n, y+n],[x+n, y-n], [x+n, y +n]]
     ul << direction[0] unless direction[0][0] <0 || direction[0][0] > 7 || direction[0][1] < 0 || direction[0][1] > 7
     ll << direction[1] unless direction[1][0] <0 || direction[1][0] > 7 || direction[1][1] < 0 || direction[1][1] > 7
     ur << direction[2] unless direction[2][0] <0 || direction[2][0] > 7 || direction[2][1] < 0 || direction[2][1] > 7
     lr << direction[3] unless direction[3][0] <0 || direction[3][0] > 7 || direction[3][1] < 0 || direction[3][1] > 7
     n += 1
    end
    possible_array << ul << ll << ur << lr
    possible_array.delete([])
    possible_array
  end
end


