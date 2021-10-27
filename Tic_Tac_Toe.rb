class Player
  attr_reader :sym, :total_player, :name
  @@total_player = 0
  def initialize(name)
    @name = name
    @@total_player += 1
    @sym = @@total_player == 1? 'X' : 'O'
  end
end

class Board
  @@board_display = [['7', '8', '9'], ['4', '5', '6'],['1', '2', '3']]
  def self.display
    puts
    @@board_display.each do |row|
      puts "  |    |    |  "
      row.each {|item| print "--#{item}--"}
      puts
    end
    puts "  |    |    |  "
    puts
  end
  def self.check=(target)
    puts @@board_display.include? target
  end
  def self.update(target, sym)
    @@board_display.each do |row|
      row.each_index do |j|
        row[j] = sym if(row[j] == target)
      end
    end
  end
  def self.check(target)
    until target >= 1 and target <= 9
      print "Invalid input, Please enter position 0-9: "
      target = gets.chomp.to_i
    end
    target
  end
end

def player_1()
  Board.display
  print "Please enter position to mark: "
  target = gets.chomp.to_i
  sym = 'X'
  Board.display
  target = Board.check(target).to_s
  Board.update(target, sym)
  Board.display
end

def player_2()
  name2 = gets.chomp
  user2 = Player.new(name2)
  Board.display
  print "Please enter position to mark: "
  target = gets.chomp.to_i
  sym = 'X'
  Board.display
  target = Board.check(target).to_s
  Board.update(target, sym)
  Board.display
end

puts "Welcome to the Tic-Tac-Toe"
enter_name()
until game_over == 1
  player_1()
  player_2()
end


