require_relative "castle"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "pawn"
module PieceInstantiator
  STARTING_POSITIONS = "♜♞♝♛♚♝♞♜♟♟♟♟♟♟♟♟                                ♙♙♙♙♙♙♙♙♖♘♗♕♔♗♘♖"

  PIECES_MAP = {
    "♜" => Castle.new("black"),
    "♞" => Knight.new("black"),
    "♝" => Bishop.new("black"),
    "♛" => Queen.new("black"),
    "♚" => King.new("black"),
    "♟" => Pawn.new("black"),
    "♙" => Pawn.new("white"),
    "♖" => Castle.new("white"),
    "♘" => Knight.new("white"),
    "♗" => Bishop.new("white"),
    "♕" => Queen.new("white"),
    "♔" => King.new("white"),
    " " => nil
  }
end
