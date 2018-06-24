require 'byebug'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end

  def take_turn
    self.show_sequence
    sequence = self.require_sequence
    if sequence != seq
      game_over_message
    end
    @sequence_length += 1 unless game_over
    self.round_success_message unless game_over
  end

  def show_sequence
    add_random_color
    puts seq
    sleep(2)
    system("clear")

  end

  def require_sequence
    print "Color sequence (with spaces between): "
    sequence = gets.chomp
    sequence.split
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "Good Job"
  end

  def game_over_message
    puts "Game Over"
    @game_over = true
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end


Simon.new.play
