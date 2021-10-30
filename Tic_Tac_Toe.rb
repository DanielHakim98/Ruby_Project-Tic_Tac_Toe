
class Player
  attr_reader :sym, :name
  @@total_player = 0

  def initialize(name)
    @name = name
    @@total_player += 1
    @sym = @@total_player == 1 ? 'X' : 'O'
    @row_container = [0, 0, 0]
    @col_container = [0, 0, 0]
    @rightdiag_container = [0, 0, 0]
    @leftdiag_container = [0, 0, 0]
    puts "Your marker will be '#{sym}'."
  end

  def play
    print "\n#{name}, please enter position to mark: "
    target = gets.chomp.to_i
    target = Board.check(target)
    coor_arr = Board.update(target, sym)
    Board.display
    check_win(coor_arr.first, coor_arr.last)
  end

  def self.total
    @@total_player
  end

  def check_win(row, col)
    @row_container[row] += 1
    @col_container[col] += 1
    @rightdiag_container[row] += 1 if row == col
    @leftdiag_container[row] += 1 if row + col + 1 == 3
    total_rightdiag = @rightdiag_container.reduce(0) { |total_sum, num| total_sum + num }

    total_leftdiag = @leftdiag_container.reduce(0) { |total_sum, num| total_sum + num }

    if @row_container[row] == 3
      puts "#{name}, you win!"
      return 1
    end

    if @col_container[col] == 3
      puts "#{name}, you win!"
      return 1
    end

    if total_rightdiag == 3
      puts "#{name}, you win!"
      return 1
    end

    if total_leftdiag == 3
      puts "#{name}, you win!"
      return 1
    end
    0
  end

end

class Board
  @@board_display = [
    %w[1 2 3],
    %w[4 5 6],
    %w[7 8 9]
  ]

  @@previous_input = []

  def self.display
    puts
    @@board_display.each do |row|
      puts ' +---+--+---+--+---+ '
      row.each { |item| print " | #{item} | " }
      puts
    end
    puts " +---+--+---+--+---+ \n"
  end

  def self.update(target, sym)
    @@coordinate = []
    @@board_display.each_with_index do |row, i|
      row.each_with_index do |item, j|
        next unless item == target.to_s
        row[j] = sym
        @@previous_input.push(target)
        @@coordinate.push(i, j)
      end
    end
    @@coordinate
  end

  def self.check(target)
    until (target >= 1) && (target <= 9)
      print "\nInvalid input, Please enter position 0-9: "
      target = gets.chomp.to_i
    end

    any_previous = @@previous_input.any? { |input| input == target }

    while any_previous == true
      puts "\nInvalid input! This position has been already inserted."
      print 'Please enter position available position 0-9: '
      target = gets.chomp.to_i
      any_previous = @@previous_input.any? { |input| input == target }
    end
    target
  end

  def self.is_draw
    if @@previous_input.length == 9
      puts "\nThe game is draw.\n"
      return 1
    end
    0
  end

  def self.start(player1, player2)
    Board.display
    loop do
      win = player1.play
      break if win > 0          #check for win condition for player 1
      draw = Board.is_draw
      break if draw > 0         #check for draw condition for the game if player 1 makes the last move.
      win = player2.play
      break if win > 0          #check for win condition for player 2
      draw = Board.is_draw
      break if draw > 0         #check for draw condition for the game if player 2 makes the last move.
    end
  end

end

def ask_name(number)
  print "\nPlease enter name for player ##{number} :"
  name = gets.chomp
end

puts '-----Welcome to the Tic-Tac-Toe-----'
player1 = Player.new(name = ask_name(Player.total + 1))
player2 = Player.new(name = ask_name(Player.total + 1))
Board.start(player1, player2)
