puts 1.0e3
puts Rational(3,4) * Rational(2,3)

Song = Struct.new(:title, :name, :length)
File.open("songdata.txt") do |musicData|
	songs = []
	musicData.each do |line|
		file, length, name, title = line.chomp.split(/\s*\|\s*/)
		name.gsub!("\t", " ")
		name.squeeze!(" ")
		songs << Song.new(title, name, length)
	end
	puts songs[0]
end

p ('bag'..'bar').to_enum


car_age = 5.3
case car_age
when 0...1
	puts "Mmm...new car smell"
when 1...3
	puts "Nice and new"
when 3...6
	puts "Reliable but slightly dinged"
when 6...10
	puts "Can be a struggle"
when 10...30
	puts "Clunker"
else
	puts "Vintage gem"
end


File.foreach("songdata.txt") do |line, index|
	puts "#{index}: #{line}" if line !~ /j\d+.mp3/
end
