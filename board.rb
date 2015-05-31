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

  attr_accessor :board, :active_piece, :captured_pieces

  def initialize
    @captured_pieces = []
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

  def check_for_piece(user_input)
    if board[user_input] = nil
      return nil
    end
    @active_piece = identify_space(user_input)
  end

  def identify_space(user_input)
    board[user_input]
  end

  def board_parse(board_string)
    @board.each_key.with_index do |position, i|
      @board[position] = PIECES_MAP[board_string[i]]
    end
  end

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
      @captured_pieces << board[second_input]
      board[second_input] = active_piece
      board[first_input] = nil
    end
    board[second_input] = active_piece
    board[first_input] = nil
  end

  def to_s
    counter = 0
    number = 8
    letters_array = [ "\n ", "A","B", "C","D", "E", "F", "G","H\n"]
    board_array = []
    self.board.each_value do |value|
      if value == nil
        board_array <<  " "
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

  def reset_screen!
    clear_screen!
    move_to_home!
  end

  private

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
          break
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

  def clear_screen!
    print "\e[2J"
  end

  def move_to_home!
    print "\e[H"
  end

end
