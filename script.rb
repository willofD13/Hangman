contents = File.read('google-10000-english-no-swears.txt')
  
lines = File.readlines('google-10000-english-no-swears.txt')
new_lines = lines.map {|line| line.gsub(/[\s]/, '')}

words = []
new_lines.each do |line|
  if line.length > 5 && line.length < 12 
    words.push(line)
  end 
end 

