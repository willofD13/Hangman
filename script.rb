# frozen_string_literal: true

File.read('google-10000-english-no-swears.txt')

lines = File.readlines('google-10000-english-no-swears.txt')
new_lines = lines.map { |line| line.gsub(/\s/, '') }

def select_word(new_lines)
  words = []
  new_lines.each do |line|
    words.push(line) if line.length > 5 && line.length < 12
  end
  p secret_word = words.sample.split('')
  display = Array.new(secret_word.length, '_')
  puts display.join(' ')
  make_guess(secret_word,display)
end

def make_guess (secret_word,display)
puts "Make your guess"
letter = gets.chomp

correct_letters = []
incorrect_letters = []

def display_choices
  if secret_word.include?(letter) == true
    correct_letters.push(letter)
  else 
    incorrect_letters.push(letter)
  end
end

i = 0
while i < secret_word.length
  if secret_word[i].eql?(letter) == true
    display[i] = letter
  end 
  i += 1
end
end

select_word(new_lines)