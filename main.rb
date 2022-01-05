# frozen_string_literal: true

# Main logic
class Game
  attr_reader :gameover

  @@color_bank = %w[red orange yellow green blue purple]

  def initialize
    @guess = { color_position_match: 0, color_match: 0 }
    @gamepad = Array.new(4) { ' ' }
    @answer = answer_generator
    @gameover = false
  end

  def info
    puts "Your matches -> CP: #{@guess[:color_position_match]}, C: #{@guess[:color_match]}."
    puts "Gamepad: #{@gamepad}"
    puts '##########################################'
    # p @answer
    # puts '##########################################'
  end

  def play
    # reset
    @guess = { color_position_match: 0, color_match: 0 }

    # get input
    loop do
      puts 'Write down your input, and split it with space.'
      input = gets.chomp.split(' ')

      next unless input.length == 4

      puts "Your input: #{input}"
      @gamepad = input
      break
    end

    # Main game logic
    @answer.each_with_index do |color, index|
      @guess[:color_match] += 1 if @gamepad.include?(color)
      if color == @gamepad[index]
        @guess[:color_match] -= 1
        @guess[:color_position_match] += 1
      end
    end

    @gameover = true if @guess[:color_position_match] == 4
    @gameover
  end

  private

  def answer_generator
    answer = []

    4.times do
      answer.push(@@color_bank.sample)
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
    puts 'YOU WIN!'
    break
  end
end

puts 'YOU LOSE!' unless game.gameover
