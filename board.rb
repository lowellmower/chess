require 'pry'
# **REQUIRED FILES MUST GO ABOVE THE MODULE BELOW**
require_relative 'piece_map'

class Board

  attr_accessor :board, :active_piece

  def initialize(board_string)
    @board_string = board_string
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

  include PieceInstantiator

  # returns piece object or nil
  def check_for_piece(user_input)
    if board[user_input] = nil
      return nil
    end
    @active_piece = identify_piece(user_input)
  end

  # return piece object
  def identify_piece(user_input)
    board[user_input]
  end

  # can take a board string and interpert characters on it to make a new board
  def board_parse
    @board.each_key.with_index do |position, i|
      @board[position] = PIECES_MAP[board_string[i]]
    end
  end

end

# have to give a new board string
board_string = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"

b = Board.new(board_string)
binding.pry
b
