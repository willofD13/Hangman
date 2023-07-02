contents = File.read('google-10000-english-no-swears.txt')
  
lines = File.readlines('google-10000-english-no-swears.txt')
new_lines = lines.map {|line| line.gsub(/[\s]/, '')}


