class Game
  #------------------------get started-----------------------------------
  def initialize
    # @board = Board.new # => {"CapitalNUMBER": PieceObject}
    @player = "purple"
  end

 #--------------------who's turn is it?----------------------------------
  def colors(player1 = "black", player2 = "white")
    @player1 = player1
    @player2 = player2
    if @player == player1
      "#{@player1.capitalize} Player"
    else
      "#{@player2.capitalize} Player"
  end

  def toggle_turn
    if @player == @player1
      @player = @player2
    else
      @player1
    end
  end

  def run
  end
#----------------------let's get/give some info--------------------------
  def which_piece
  #   #gets users's move (which piece)
  end

  def available_positions
  #   #gives list of all available positions for the piece
  end

  def what_move
    #asks for move... which position from list of available positions
  end
end
