class Piece
  attr_accessor :captured
  attr_reader :color
  def initialize(color = "black")
    @captured = false
    @color = color
  end

  # def coordinate(index)
  #   x = index/ 8
  #   y = index % 8
  # end
end
