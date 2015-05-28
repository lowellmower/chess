class Piece
  attr_accessor :captured?
  attr_reader :color
  def initialize(color = "black")
    @captured? = false
    @color = color
  end



end