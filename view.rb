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

  def self.white_ask_position(position)
    puts "white, move #{position} where?"
  end

  def self.white_confirm_move(old_position, new_position)
    puts "Ok, white move from #{old_position} to #{new_position}"
  end

  def self.black_move
    puts "Black's turn"
    puts "Black, your move"
  end

  def self.moves_for_black(users_input, x)
    puts "moves for #{users_input}: #{x}"
  end

  def self.black_ask_position(position)
    puts "black, move #{position} where?"
  end

  def self.black_confirm_move(old_position, new_position)
    puts "Ok, black move from #{old_position} to #{new_position}"
  end



end


