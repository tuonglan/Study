require 'csv'
require_relative 'BookInStock'


class CSVReader
	def initialize 
		@booksInStore = []
	end

	def readCSVFile(csvFile)
		CSV.foreach(csvFile, headers: true) do |row|
			@booksInStore << BookInStock.new(row["ISBN"], row["Amount"])
		end
	end

	def totalValueInStock
		sum = 0.0
		@booksInStore.each {|book| sum += book.price}
		sum
	end
end
