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

  def initialize
    @active_piece = nil
    @board = Hash.new
    ('0'..'7').each do |x|
      ('0'..'7').each do |y|
        location = "#{x},#{y}"
        @board[location] = nil
      end
    end
    @board.each_key.with_index do |position, i|
      @board[position] = PIECES_MAP[STARTING_POSITIONS[i]]
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

  def call_for_moves(user_input)
    case @board[user_input]
    when Pawn
      eligible_moves_p(user_input)
    when Castle, Queen, Bishop
      eligible_moves_bcq(user_input)
    when King, Knight
      eligible_moves_nk(user_input)
    end
  end

  def move(first_input,second_input)
    active_piece = board[first_input]
    if board[second_input] != nil
      board[second_input].captured = true
      board[second_input] = active_piece
    else
      board[second_input] = active_piece
      board[first_input] = nil
    end
  end

  def display
    counter = 0
    number = 8
    letters_array = [ "\n  ", "A","B", "C","D", "E", "F", "G","H","\n"]
    board_array = []
    self.board.each_value do |value|
      if value == nil
        board_array << value
      else
        board_array << value.picture
      end
    end
    while counter < 64
       board_array.insert(counter,"\n#{number}")
       counter += 9
       number -=1
     end
    board_array << letters_array
    board_string = board_array.flatten.join("  ")
    board_string
  end

  private
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
  #eligable moves for white and black pawns
  def eligible_moves_p(user_input)
    eligible_moves = []
    x = user_input[0].to_i
    y = user_input[-1].to_i
    # black pawn move
    if board[user_input].color == "black"
      if (board[user_input].is_a? Pawn) && (board[[x + 1, y].join(",")] == nil)
        eligible_moves << [x + 1, y]
      end
      if (board[user_input].is_a? Pawn) && (board[[x + 1, y + 1].join(",")] != nil && board[[x + 1, y + 1].join(",")].color != board[user_input].color)
        eligible_moves << [x + 1, y + 1]
      end
      if (board[user_input].is_a? Pawn) && (board[[x + 1, y - 1].join(",")] != nil && board[[x + 1, y - 1].join(",")].color != board[user_input].color)
        eligible_moves << [x + 1, y - 1]
      end
      eligible_moves
    end
    # white pawn move
    if board[user_input].color == "white"
      if (board[user_input].is_a? Pawn) && (board[[x - 1, y].join(",")] == nil)
        eligible_moves << [x - 1, y]
      end
      if (board[user_input].is_a? Pawn) && (board[[x - 1, y + 1].join(",")] != nil && board[[x - 1, y + 1].join(",")].color != board[user_input].color)
        eligible_moves << [x - 1, y + 1]
      end
      if (board[user_input].is_a? Pawn) && (board[[x - 1, y - 1].join(",")] != nil && board[[x - 1, y - 1].join(",")].color != board[user_input].color)
        eligible_moves << [x - 1, y - 1]
      end
    end
    eligible_moves
  end

end

b = Board.new
b
binding.pry
