class Player
  attr_reader :name, :symbol
  @@counter = 0
  def initialize(name,symbol="#{name[0..2].downcase}")
    @name = name
    @symbol = symbol
    @@counter += 1
  end
  def position

  end
  def self.total_player
    puts "Total player: #{@@counter}"
  end
end

class Board
  @@board_array = [[0,0,0],[0,0,0],[0,0,0]]
  def self.graphic
    puts
    for i in 0...3
      for j in 0...3
        print "  #{@@board_array[i][j]}  "
      end
      puts puts
    end
  end

  def self.replace (pstn,logo)
    for i in 0...3
      for j in 0...3
        @@board_array[pstn[0]][pstn[1]]=logo
      end
    end
  end
end

player1 = Player.new("Daniel")
player2 = Player.new("Lidya")

pstn = Array.new
for i in 0...2
  print "Enter #{i+1} number for coordinate: "
  pstn[i]= gets.chomp.to_i
  puts pstn[i]
end
puts

Board.replace(pstn,"x")
Board.graphic











