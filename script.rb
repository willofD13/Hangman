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
  
  def initialize(data = nil)
    

    if Dir.exist?('saved_games') && data.nil?
      puts "Type 'load' if you want to load a game"
      input = gets.chomp
      if input == 'load'
        load_game
      else
        new_game
      end
    elsif Dir.exist?('saved_games') && !data.nil?
      
      @secret_word = data[:secret_word]
      @display = data[:display]
      @correct_letters = data[:correct_letters] 
      @incorrect_letters = data[:incorrect_letters]
      p @display.join('_')
      
      make_guess
    else 
      new_game
    end
  end

  def new_game
    @secret_word = @@words.sample.split('')
    @correct_letters = []
    @incorrect_letters = []
    @display = Array.new(@secret_word.length, '_')
    puts @display.join(' ')
    make_guess
  end
  
  private

  def make_guess
    
    while @@guesses > 0
 
      puts "Make your guess. #{@@guesses} guesses and you are hanged! Type 'save' if you want to save"
      input = gets.chomp.downcase
      if input == 'save' 
        save_game 
      elsif input.length != 1
        puts "One letter only!"
        make_guess
      end

      display_letters(input)
    end
  end

  def save_game
    puts "choose your file from 1-5"
        answer = gets.chomp 
        Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
        File.open("./saved_games/#{answer}.yml", 'w') { |f| f.write(to_yaml) }
  end

  def load_game
    puts "Choose the save file from 1-5"
      answer = gets.chomp 
      Game.from_yaml("./saved_games/#{answer}.yml")
  end


  def display_letters(letter)
    if secret_word.include?(letter) == true
      correct_letters.push(letter)
    else
      incorrect_letters.push(letter)
      @@guesses -= 1
        if @@guesses == 0
          puts "You are hanged..."
          puts secret_word.join('_')
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
     

  def to_yaml
    YAML.dump ({
      :secret_word => @secret_word,
      :display => @display,
      :correct_letters => @correct_letters,
      :incorrect_letters => @incorrect_letters
    })
  end

  def self.from_yaml(string)
    data = YAML.load(File.read(string))
    
    self.new(data)
    
  end
end

game = Game.new

