# frozen_string_literal: true
#require 'pry-byebug'
require 'yaml'
class Game
  @@guesses = 6 ##keep count with this

  File.read('google-10000-english-no-swears.txt')

  lines = File.readlines('google-10000-english-no-swears.txt').map { |line| line.gsub(/\s/, '') }
    
    
  @@words = []
    lines.each do |line|
      @@words.push(line) if line.length > 5 && line.length < 12
    end
    

  attr_reader :secret_word,:display
  attr_accessor :correct_letters,:incorrect_letters
  
  def initialize
    
    @secret_word = @@words.sample.split('')
    @correct_letters = []
    @incorrect_letters = []
    @display = Array.new(@secret_word.length, '_')
    puts @display.join(' ')
    make_guess
  end


  def make_guess
    
    while @@guesses > 0
      
      puts "Do you want to save?"
      answer = gets.chomp
      if answer == 'y'
        to_yaml
      end

      puts "Make your guess. #{@@guesses} guesses and you are hanged!"
      letter = gets.chomp.downcase
      

      display_letters(letter)
    end
  end
      
    def display_letters(letter)
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
      display_word(letter)
    end
    
    def display_word(letter)
      i = 0
      while i < secret_word.length
        display[i] = letter if secret_word[i].eql?(letter) == true
        i += 1
      end
      puts display.join(' ')

      display.each_with_index do |e,i|
        v = e.ord
          if v < 97 || v > 122
            break
          elsif v >= 97 && v <= 122 && i == display.length - 1
              puts "You found the word"
              @@guesses = 0
          elsif v >= 97 && v <= 122 && i != display.length - 1
            next
          end
      end
    end
      #binding.pry

  def to_yaml
    YAML.dump ({
      :secret_word => @secret_word,
      :display => @display,
      :correct_letters => @correct_letters,
      :incorrect_letters => @incorrect_letters
    })
  end

  def self.from_yaml(string)
    data = yaml.load string
    self.new(data[:secret_word], data[:display], data[:correct_letters], data[:incorrect_letters])
  end
end

game = Game.new

