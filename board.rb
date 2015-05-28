require 'pry'
class Board

  attr_accessor :board

  def initialize
    @board = {}
    ('A'..'H').each do |letter|
      ('1'..'8').each do |number|
        location = "#{letter}#{number}"
        board[location] = Piece.new
      end
    end
  end

  def set_board
    #set values == piece obj at specific keys
    @board.each_key do |key|
      if key == "A8" || key == "H8" || key == "A1" || key == "H1"
        @board[key] = Castle.new
      end
    end
  end

end

class Piece
end

class Castle < Piece
end



b = Board.new
b.set_board
binding.pry