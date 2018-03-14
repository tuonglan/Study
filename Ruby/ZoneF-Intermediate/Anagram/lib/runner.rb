require 'finder'
require 'options'


module Anagram
	class Runner
		def initialize argv
			@options = Options.new argv
		end

		def run
			@finder = Finder.from_file(@options.dictionary)
			@options.words_to_find.each do |word|
				anagrams = @finder.lookup word
				if !anagrams.empty?
					puts "The anagrams for #{word} is: #{anagrams}"
				else
					puts "There's no anagrams for #{word} in #{@options.dictionary}"
				end
			end
		end
	end
end
