class Player
  attr_reader :sym, :name
  @@total_player = 0
  def initialize(name)
    @name = name
    @@total_player += 1
    @sym = @@total_player == 1? 'X' : 'O'
    puts "Your marker will be '#{sym}'."
  end
  def play()
    print "\n#{name}, please enter position to mark: "
    target = gets.chomp.to_i
    target = Board.check(target)
    Board.update(target, sym)
    Board.display
  end
  def self.total
    @@total_player
  end
end

class Board
  @@board_display = {
    :row1 => {1 =>'1', 2 =>'2', 3 =>'3'},
    :row2 => {4 =>'4', 5 =>'5', 6 =>'6'},
    :row3 => {7 =>'7', 8 =>'8', 9 =>'9'}
  }
  @@previous_input = []
  def self.display
    puts
    @@board_display.each do |key, row|
      puts "  |    |    |  "
      row.each {|k, item| print "--#{item}--"}
      puts
    end
    puts "  |    |    |  \n"
  end

  def self.update(target, sym)
    @@board_display.each do |key, row|
      row.each do |k, v|
        if(k == target)
          row[k] = sym
          @@previous_input.push(target)
        end
      end
    end
  end

  def self.check(target)
    until target >= 1 and target <= 9
      print "\nInvalid input, Please enter position 0-9: "
      target = gets.chomp.to_i
    end

    any_previous = @@previous_input.any? {|input| input == target}

    while any_previous == true
      puts "\nInvalid input! This position has been already inserted."
      print "Please enter position available position 0-9: "
      target = gets.chomp.to_i
      any_previous = @@previous_input.any? {|input| input == target}
    end
    target
  end

end

def ask_name(number)
  print "\nPlease enter name for player ##{number} :"
  name = gets.chomp
end

puts "-----Welcome to the Tic-Tac-Toe-----"
player1 =Player.new(name = ask_name(Player.total + 1))
player2 =Player.new(name = ask_name(Player.total + 1))

winner = 0
Board.display

while (winner == 0)
  player1.play
  player2.play
end

