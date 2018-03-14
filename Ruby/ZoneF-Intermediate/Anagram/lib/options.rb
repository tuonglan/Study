require 'optparse'

module Anagram
	class Options
		DEFAULT_DICTIONARY = "/usr/share/dict/words"
		attr_reader :dictionary, :words_to_find

		def initialize argv
			@dictionary = DEFAULT_DICTIONARY
			parse argv
			@words_to_find = argv
		end

	private
		def parse argv
			OptionParser.new argv do |opts|
				# Setup the option parser
				opts.banner = "Usage: anagram [options] word..."
				opts.on('-d', '--dict path', String, 'Dictionary path') do |path|
					@dictionary = path
				end
				opts.on('-h', '--help', 'Show the help') do
					puts opts
					exit
				end

				begin
					argv = ['-h'] if argv.empty?
					opts.parse! argv
				rescue OptionParser::ParseError => e
					STDERR.puts e.message, "\n", opts
					exit -1
				end
			end
		end
	end
end
