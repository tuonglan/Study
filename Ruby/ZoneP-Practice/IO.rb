f = File.open("input.txt")
puts f.gets
f.close

data = []
File.open("dummy_data.txt").each do |line|
	data << line
end
p data

fileStr = File.read("dummy_data.txt")
p fileStr
fileArr = File.readlines("dummy_data.txt")
p fileArr

File.open("text.txt", "w") do |f|
	f.puts "This is a test"
	f.puts "This is another ine"
end
File.rename("text.txt", "powers.txt")

puts File.mtime("powers.txt")
puts File.size("powers.txt")

#puts Dir.chdir("../")
puts Dir.pwd

require 'csv'
CSV.open("dummy_data.csv", "r").each do |person|
	puts person.inspect
end
