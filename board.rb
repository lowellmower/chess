require 'pry'
class Board

  attr_accessor :board

  def initialize
    @board = {}
    ('A'..'H').each do |letter|
      ('1'..'8').each do |number|
        location = "#{letter}#{number}"
        board[location] = nil
      end
    end
  end

  def set_board
    #set values == piece obj at specific keys
    @board.each_key do |key|
      case key
      when "A8","H8","A1","H1"
        @board[key] = Castle.new
      when "B8","G8","B1","G1"
        @board[key] = Knight.new
      when "C8","F8","C1","F1"
        @board[key] = Bishop.new
      when "D8","E1"
        @board[key] = Queen.new
      when "E8","D1"
        @board[key] = King.new
      when "A7","B7","C7","D7","E7","F7","G7","H7",
           "A2","B2","C2","D2","E2","F2","G2","H2"
        @board[key] = Pawn.new
      end
    end
  end

end

class Piece
end

class Castle < Piece
end

class Knight < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class King < Piece
end

class Pawn < Piece
end



b = Board.new
b.set_board
binding.pry