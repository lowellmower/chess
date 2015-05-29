require 'pry'
# **REQUIRED FILES MUST GO ABOVE THE MODULE BELOW**
require_relative 'castle'
require_relative 'knight'
require_relative 'king'
require_relative 'pawn'
require_relative 'bishop'
require_relative 'queen'
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
    @active_piece = identify_space(user_input)
  end

  # return piece object
  def identify_space(user_input)
    board[user_input]
  end

  # can take a board string and interpert characters on it to make a new board
  def board_parse(board_string)
    @board.each_key.with_index do |position, i|
      @board[position] = PIECES_MAP[board_string[i]]
    end
  end

  # ask piece for where it can move from current location
  def possible_piece_moves(user_input)
    board[user_input].how_can_i_move(user_input)
  end

  # itterate over possible moves and check board for pieces
  # returns 2D array of possible moves
  # Bishop Castle Queen
  # takes a string "3,2" || "0,2" ...etc.
  def eligible_moves_bcq(user_input)
    eligible_moves = []
    moves_array = possible_piece_moves(user_input)
    # 3D array
    moves_array.each do |sub_array|
      sub_array.each do |coord_array|
        if board[coord_array.join(",")] == nil
          eligible_moves << coord_array
        elsif board[coord_array.join(",")] != nil && board[coord_array.join(",")].color != board[user_input].color
          eligible_moves << coord_array
          break
        elsif board[coord_array.join(",")].color == board[user_input].color
        end
        next
      end
    end
    eligible_moves
  end

  # eligible moves for knight and king pieces
  def eligible_moves_nk(user_input)
    eligible_moves = []
    moves_array = possible_piece_moves(user_input)
    moves_array.each do |coord_array|
      if board[coord_array.join(",")] == nil
        eligible_moves << coord_array
      elsif board[coord_array.join(",")] != nil && board[coord_array.join(",")].color != board[user_input].color
        eligible_moves << coord_array
      else board[coord_array.join(",")].color == board[user_input].color
      end
    end
    eligible_moves
  end

  def eligible_moves_p(user_input)
    # check if pawn if pawn is first move == true || false
      # return all eligable moves based on current logic
      #
  end

end


# have to give a new board string
board_string = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"
b = Board.new(board_string)
b.board["6,5"] = Pawn.new("white")

# binding.pry
b.eligible_moves_npk("6,5")
