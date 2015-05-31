module View

  def self.welcome_message
    puts "welcome to chess... blah blah blah"
  end


  def self.display(board_string)
    print board_string
  end

  def self.white_move
    puts "\nWhite's turn"
    puts "\nWhite, select a piece (example: A2):"
  end

  def self.black_move
    puts "\nBlack's turn"
    puts "\nBlack, select a piece (example: B7):"
  end

  def self.get_input
    gets.chomp
  end

  def self.moves_for_white(users_input, x)
    puts "moves for #{users_input}: #{x}"
  end

end


