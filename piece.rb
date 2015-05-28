class Piece
  attr_accessor :captured
  attr_reader :color
  def initialize(color = "black")
    @captured = false
    @color = color
  end

  #def current position(index)
  # (x-cord = index / 8, y-cord = index % 8)
  # end
end
