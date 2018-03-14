dataDir = '/usr/share/dict/words'


class ScrabbleStems
	def initialize
		@stems = {}
	end

	def readDict filename
		File.open(filename, 'r').each do |line|
			word = line.chomp.downcase
			next if word.length != 7
			letters = word.split("").sort
			uniques = letters.uniq
			uniques.each do |letter|
				stem = letters.join.sub(letter,'')
				@stems[stem] ||= {}
				@stems[stem][letter] ||= []
				@stems[stem][letter] << word
			end
		end
	end

	def printStems threshold
		@stems.each do |key, value|
			puts "#{key}: #{value.size}: #{value}" if value.size >= threshold	
		end
	end
end


stemSeeker = ScrabbleStems.new
stemSeeker.readDict dataDir
stemSeeker.printStems ARGV[0].to_i
