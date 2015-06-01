require_relative "castle"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "pawn"
module PieceInstantiator
  STARTING_POSITIONS = "RNBQKBNRPPPPPPPP                                pppppppprnbqkbnr"
  ROSS_POSITIONS = "RNBQKBNR                                                rnbqkbnr"
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
    "q" => Queen.new("white"),
    "k" => King.new("white"),
    " " => nil
  }

  # REVERSE_PIECES_MAP = {
  #   "Castleblack" ==
  # }
end
