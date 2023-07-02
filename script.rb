# frozen_string_literal: true

File.read('google-10000-english-no-swears.txt')

lines = File.readlines('google-10000-english-no-swears.txt')
new_lines = lines.map { |line| line.gsub(/\s/, '') }

def select_word(new_lines)
  words = []
  new_lines.each do |line|
    words.push(line) if line.length > 5 && line.length < 12
  end
  secret_word = words.sample
  display = Array.new(secret_word.length, '_')
  puts display.join(' ')
end
select_word(new_lines)

puts "Make your guess"
letter = gets.chomp

correct_letters = []
incorrect_letters = []
