# frozen_string_literal: true
#require 'pry-byebug'
class Game
  @@guesses = 6 ##keep count with this

  File.read('google-10000-english-no-swears.txt')

  attr_reader :secret_word,:display
  attr_accessor :correct_letters,:incorrect_letters
  
  def initialize
    @lines = File.readlines('google-10000-english-no-swears.txt').map { |line| line.gsub(/\s/, '') }
    
    
    @words = []
    @lines.each do |line|
      @words.push(line) if line.length > 5 && line.length < 12
    end

    @secret_word = @words.sample.split('')
    @display = Array.new(@secret_word.length, '_')
    puts @display.join(' ')
    make_guess(secret_word,display)
  end


  def make_guess(secret_word,display)
    correct_letters = []
    incorrect_letters = []
    while @@guesses > 0
      puts "Make your guess. #{@@guesses}guesses and you are hanged!"
      letter = gets.chomp
      
 
      if secret_word.include?(letter) == true
        correct_letters.push(letter)
      else
        incorrect_letters.push(letter)
        @@guesses -= 1
          if @@guesses == 0
            puts "You are hanged..."
          end
      end
      puts "correct letters :#{correct_letters}"
      puts "incorrect letters : #{incorrect_letters}"

      i = 0
      while i < secret_word.length
        display[i] = letter if secret_word[i].eql?(letter) == true
        i += 1
      end
      puts display.join(' ')
      
      #binding.pry
    end
  end
end

game = Game.new

