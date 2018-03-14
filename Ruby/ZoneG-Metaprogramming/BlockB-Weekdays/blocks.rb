class MyProc
	def self.make_proc &block
		MyProc.new block
	end

	def initialize block
		@blk = block
	end

	def call *args
		@blk.call *args
	end
end


def outer_method
	@x = 7
	puts "This is outer method"
end

def my_method
	outer_method
	puts "The value of x is:#{@x}"
end


class Dog
	@count = 7
	def self.speak
		puts "There are #{@count}"
	end

	class << self
		@type = 11
		def self.getType; @type; end

		def pronounce
			puts "The count: #{@count} and type: #{self.singleton_class.getType}"
		end
	end
end
Dog.speak
Dog.pronounce




