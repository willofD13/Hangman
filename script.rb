contents = File.read('google-10000-english-no-swears.txt')

lines = File.readlines('google-10000-english-no-swears.txt')
lines.each do |line|
  puts line
end