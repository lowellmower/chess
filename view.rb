module View

  def self.welcome_message
    puts "welcome to chess... blah blah blah"
  end

  def self.display(board_string)
    counter = 0
    number = 8



    board_array = board_string.split('')
    while counter < 64
       board_array.insert(counter,number)
       counter += 9
       number -=1
     end

    board_array.each_slice(9){|x| puts x.join(' ')}

    puts "  A B C D E F G H"
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


