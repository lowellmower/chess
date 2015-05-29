require 'pry'

  # STARTING_POSITIONS = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"


class Castle
  def initialize(color)
    @color = color
  end
end

class Knight
  def initialize(color)
    @color = color
  end
end

class Bishop
  def initialize(color)
    @color = color
  end
end

class Queen
  def initialize(color)
    @color = color
  end
end

class King
  def initialize(color)
    @color = color
  end
end

class Pawn
  def initialize(color)
    @color = color
  end
end


module Stuff
  STARTING_POSITIONS = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"

  PIECES_MAP = {
    "R" => Castle.new("black"),
    "N" => Knight.new("black"),
    "B" => Bishop.new("black"),
    "Q" => Queen.new("black"),
    "K" => King.new("black"),
    "P" => Pawn.new("black"),
    "p" => Pawn.new("white"),
    "r" => Castle.new("white"),
    "n" => Knight.new("white"),
    "b" => Bishop.new("white"),
    "q" => Queen.new("white")
    " " => nil
  }
end


class Board

  attr_accessor :board, :active_piece

  def initialize(board_string)
    @active_piece = nil
    @board = Hash.new
    ('0'..'7').each do |x|
      ('0'..'7').each do |y|
        location = "#{x},#{y}"
        @board[location] = nil
      end
    end
    @board.each_key.with_index do |position, i|
      @board[position] = PIECES_MAP[board_string[i]]
    end
  end

  include Stuff

  def check_for_piece(user_input)
    # returns piece object or nil
    if board[user_input] = nil
      return nil
    end
    @active_piece = identify_piece(user_input)
  end

# return piece object
  def identify_piece(user_input)
    board[user_input]
  end

end

board_string = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"

b = Board.new(board_string)
binding.pry
b
