require 'pry'

class Board

  attr_accessor :board

  def initialize
    @board = {}
    ('0'..'7').each do |x|
      ('0'..'7').each do |y|
        location = "#{x},#{y}"
        board[location] = nil
      end
    end
  end

  def set_new_board
    board.each_key do |key|
      case key
      when "0,0", "7,0"
        board[key] = Castle.new("white")#black
      when "0,7", "7,7"
        board[key] = Castle.new("white")#white
      when "0,1", "0,6"
        board[key] = Knight.new("white") #black
      when "7,1", "7,6"
        board[key] = Knight.new("white") #white
      when "0,2", "0,5"
        board[key] = Bishop.new("white")#black
      when "7,2", "7,5"
        board[key] = Bishop.new("white")#white
      when "0,3"
        board[key] = Queen.new("white")#black
      when "7,3"
        board[key] = Queen.new("white")#white
      when "0,4"
        board[key] = King.new("white")#black
      when "7,4" #white
        board[key] = King.new("white")#white
      when "1,0", "1,1", "1,2", "1,3", "1,4", "1,5", "1,6", "1,7"
        board[key] = Pawn.new("white")#black
      when "6,0", "6,1", "6,2", "6,3", "6,4", "6,5", "6,6", "6,7"
        board[key] = Pawn.new("white")#white
      end

    end
  end

end
