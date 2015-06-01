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
  attr_reader :check
  attr_accessor :board, :active_piece, :captured_pieces, :checkmate, :current_state_of_board

  def initialize
    @captured_pieces = []
    @active_piece = nil
    @check = false
    @checkmate = false
    @current_state_of_board = ""
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
      # binding.pry
      @board[position] = PIECES_MAP[board_string[i]]
    end
  end

  def save_current_state_of_board
    @current_state_of_board = ""
    @board.values.each do |piece|
      if piece == nil
        @current_state_of_board += " "
      elsif piece.color == "black"
        if piece.class == Castle
          @current_state_of_board += "R"
          next
        end
        if piece.class == Knight
          @current_state_of_board += "N"
          next
        end
        @current_state_of_board += piece.class.to_s[0]
      else
        if piece.class == Castle
          @current_state_of_board += "r"
          next
        end
        if piece.class == Knight
          @current_state_of_board += "n"
          next
        end
        @current_state_of_board += piece.class.to_s[0].downcase
      end
    end
  end

  def possible_piece_moves(user_input)
    board[user_input].how_can_i_move(user_input)
  end

  def check_for_check_other_team(converted_2)
    color_of_team_that_just_moved = @board[converted_2].color
    other_team_king = @board.select {|coordinate, value| value.class == King && value.color != color_of_team_that_just_moved}
    other_team_king_key = []
    other_team_king.keys.join.split(",").each do |letter|
       other_team_king_key << letter.to_i
     end
    @board.each_pair do |coordinate,piece|
      if piece != nil
        if piece.color == color_of_team_that_just_moved
          if self.call_for_moves(coordinate).include?(other_team_king_key)
            return true
          end
        end
      end
    end
    false
  end

  def did_you_move_to_check?(converted_2)
    color_of_team_that_just_moved = @board[converted_2].color
    team_king = @board.select {|coordinate, value| value.class == King && value.color == color_of_team_that_just_moved}
    team_king_key = []
    team_king.keys.join.split(",").each do |letter|
       team_king_key << letter.to_i
     end
    @board.each_pair do |coordinate,piece|
      if piece != nil
        if piece.color != color_of_team_that_just_moved
          if self.call_for_moves(coordinate).include?(team_king_key)
            return true
          end
        end
      end
    end
    false
  end

  def check_for_checkmate(converted_2)
    all_possible_moves = []
    array_of_pieces_to_check = []
    possible_enemy_moves = []
    color_of_team_that_just_moved = @board[converted_2].color
    other_team_king = @board.select {|coordinate, value| value.class == King && value.color != color_of_team_that_just_moved}
    other_team_king_key = other_team_king.keys
    king_possible_moves = call_for_moves(other_team_king_key[0])
    return false if king_possible_moves.empty?
    @board.each_pair do |coordinate,piece| #this will get all of the moves of the black team if a white piece just moved
      if piece != nil
        if piece.color != color_of_team_that_just_moved
          piece_moves = self.call_for_moves(coordinate)
          piece_moves.each do |move|
            all_possible_moves << move
          end
        end
      end
    end
    @board.each_pair do |coordinate, piece|
      if piece != nil
        if piece.color == color_of_team_that_just_moved
          if all_possible_moves.include?(coordinate) == false
            array_of_pieces_to_check << piece
          end
        end
      end
    end
    hash_of_pieces_to_check = @board.select do |coordinate, piece|
        if array_of_pieces_to_check.include?(piece)
          piece
      end
    end
    hash_of_pieces_to_check.each_pair do |coordinate, piece|
      possible_enemy_moves << call_for_moves(coordinate)
    end
    possible_enemy_moves.each do |array_of_moves|
      king_possible_moves -= array_of_moves
    end
    if king_possible_moves.empty?
      @checkmate = true
    end
    @checkmate
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




