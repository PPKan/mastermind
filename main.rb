# frozen_string_literal: true

# Main logic
class Game
  attr_reader :gameover, :player

  @@color_bank = %w[red orange yellow green blue purple]

  def initialize
    @guess = { color_position_match: 0, color_match: 0 }
    @gamepad = []
    @player = get_player
    @answer = answer_generator(@player)
    @gameover = false
  end

  def info
    puts '##########################################'
    puts "Your matches -> CP: #{@guess[:color_position_match]}, C: #{@guess[:color_match]}."
    puts "Gamepad: #{@gamepad}"
    puts '##########################################'
    # p @answer
    # puts '##########################################'
  end

  def play
    # reset

    case @player
    when 'guesser'
      human_play
    when 'banker'
      computer_play
    end
    
    @guess = { color_position_match: 0, color_match: 0 }

    judge

    @gameover = true if @guess[:color_position_match] == 4
    @gameover
  end

  def get_player
    loop do
      puts '0: Guesser, 1: Banker'
      index = gets.chomp.to_i

      case index
      when 0
        return 'guesser'
      when 1
        return 'banker'
      end
    end
  end

  private

  def computer_play
    @gamepad = []
    4.times do
      @gamepad.push(@@color_bank.sample)
    end
  end

  def human_play
    loop do
      puts 'Write down your input from [red orange yellow green blue purple], and split it with space.'
      input = gets.chomp.split(' ')

      next unless input.length == 4

      #   puts "Your input: #{input}"
      @gamepad = input
      break
    end
  end

  def judge
    @answer.each_with_index do |color, index|
      @guess[:color_match] += 1 if @gamepad.include?(color)
      if color == @gamepad[index]
        @guess[:color_match] -= 1
        @guess[:color_position_match] += 1
      end
    end
  end

  def answer_generator(who)
    answer = []
    if who == 'guesser'
      4.times do
        answer.push(@@color_bank.sample)
      end
    else
      loop do
        puts 'Create your own answer!'
        input = gets.chomp.split(' ')
        answer = input
        next unless input.length == 4

        break
      end
    end
    answer
  end
end

# Main game goes here
game = Game.new

12.times do
  game.play
  game.info

  if game.gameover
    if game.player == 'banker'
      puts 'You LOSE! Computer WIN!'
    else
      puts 'You WIN! Computer Lose!'
      break
    end
  end
end

if game.player == 'banker'
  puts 'You WIN! Computer Lose!'
else
  puts 'You LOSE! Computer WIN!'
end
