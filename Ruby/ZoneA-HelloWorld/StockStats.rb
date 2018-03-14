require_relative 'CVSReader'

reader = CSVReader.new
ARGV.each do |fileName|
	STDERR.puts "Processing #{fileName}"
	reader.readCSVFile(fileName)
end

puts "Toval value = #{reader.totalValueInStock}"
