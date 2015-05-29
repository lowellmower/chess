class Piece
  attr_accessor :captured
  attr_reader :color
  def initialize(color = "black")
    @captured = false
    @color = color
  end

  def split_coordinate(xy)
    xy.split(",").map {|num| num.to_i}
  end
end
