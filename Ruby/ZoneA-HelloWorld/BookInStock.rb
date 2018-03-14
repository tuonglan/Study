class BookInStock
	attr_reader :isbn, :type
	attr_accessor :price
	def initialize(isbn, price)
		@isbn = isbn
		@price = Float(price)
	end

	def to_s
		"ISBN: #{@isbn}, Price: #{@price}"
	end

	def priceInCents
		Integer(@price*100 + 0.5)
	end

	def priceInCents= (cents)
		@price = cents/100
	end
end
