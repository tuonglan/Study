module Anagram
	class Finder
		def self.from_file(file_name)
			new File.readlines(file_name)
		end

		def initialize dictionary_words
			@signature = Hash.new
			dictionary_words.each do |line|
				word = line.chomp
				signature = Finder.signature_of word
				(@signature[signature] ||= []) << word
			end
		end

		def lookup word
			signature = Finder.signature_of word
			@signature[signature]
		end

		def self.signature_of word
			word.unpack("c*").sort.pack("c*")
		end
	end
end
