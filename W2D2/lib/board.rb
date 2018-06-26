require "byebug"
require_relative "mancala"
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14){Array.new}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0...13).to_a.each do |i|
      4.times { cups[i] << :stone unless i == 6 }
    end

  end

  def [] (pos)
    @cups[pos]
  end

  def []= (pos,val)
    @cups[pos] = val
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless (start_pos.between?(0,12) &&  start_pos != 6)
    # debugger
    raise "Starting cup is empty" if self[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = self[start_pos]
    self[start_pos] = []
    id = start_pos
    until stones.length == 0
      id += 1
      id = 0 if id > 13
      self[id] << stones.pop if id == 6 && current_player_name == @name1
      self[id] << stones.pop if id == 13 && current_player_name == @name2
      self[id] << stones.pop unless id == 6 || id == 13
    end

    self.render
    self.next_turn(id)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == 6 || ending_cup_idx == 13
    return :switch if self[ending_cup_idx].length == 1
    ending_cup_idx

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if (0...6).all? { |id| self[id].empty? } || (7...13).all? { |id| self[id].empty? }
    false
  end

  def winner

    if self[6] == self[13]
      return :draw
    elsif self[6].length > self[13].length
      return @name1
    else
      return @name2
    end

  end
end
