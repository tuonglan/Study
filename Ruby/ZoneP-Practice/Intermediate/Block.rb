class Lists
	@data = (1..21).to_a
	attr_accessor :one
	def initialize
		@arr = %w{One Two Three Four File}
	end
	
	def increase
		@one = 99.99
	end

	def showUp
		p @one
		p @arr
	end

	def self.classShowUp
		p @data
	end
end

x = Lists.new
x. increase
p x.showUp
Lists.classShowUp


def likeMap(array)
	newArr = []
	array.each do |ele|
		newArr << (yield ele)
	end
	newArr
end
basic = (1..10).to_a
p (likeMap(basic) {|ele| ele*ele})
