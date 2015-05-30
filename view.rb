module View

  def self.welcome_message
    puts "welcome to chess... blah blah blah"
  end


  def self.display(board_string)
    print board_string
  end


  def self.white_move
    puts "White's turn"
    puts "White, your move"
  end

  def self.get_input
    gets.chomp
  end

  def self.moves_for_white(users_input, x)
    puts "moves for #{users_input}: #{x}"
  end

end


