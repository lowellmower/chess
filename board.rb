require 'pry'
# **REQUIRED FILES MUST GO ABOVE THE MODULE BELOW**
#require_relative 'dummies'
require_relative 'bishop'
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

  # ask piece for where it can move from current location
  def possible_piece_moves(user_input)
    possible_moves = board[user_input].how_can_i_move(user_input)
  end

  # itterate over possible moves and check board for pieces
  # returns 2D array of possible moves
  # Bishop Castle Queen
  def eligible_moves_bcq(user_input)
    results = []
    moves_array = possible_piece_moves(user_input)
    # 3D array
    moves_array.each do |sub_array|
      sub_array.each do |coord_array|
        if @board[coord_array.join(",")] == nil || @board[coord_array.join(",")].color != board[user_input].color
          results << coord_array
        else @board[coord_array.join(",")].color == board[user_input].color
        end
        next
      end
    end
    results
        #binding.pry
  end

end

# have to give a new board string
# board_string = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"
# b = Board.new(board_string)
# # binding.pry
# b.board["3,6"] = Bishop.new("black")
# b.eligible_moves_bcq("3,6")
