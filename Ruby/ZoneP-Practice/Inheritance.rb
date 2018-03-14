class Top
	@@A = 1
	@@B = 1
	def bump 
		puts values 
	end
	def values
		"#{self.class.name}: @@A = #@@A, @@B = #@@B"
	end
end

class MiddleOne < Top
	@@B = 2
	@@C = 2
	def values
		super + ", C = #@@C"
	end
end


class MiddleTwo < Top
	@@B = 3
	@@C = 3
	def values
		super + ", C = #@@C"
	end
end


class BottomOne < MiddleOne; end
class BottomTwo < MiddleTwo; end

puts Top.new.bump
puts MiddleOne.new.bump
puts MiddleTwo.new.bump
puts BottomOne.new.bump
puts BottomTwo.new.bump


class Dog
	@@count = 0;
	@pop = 3
	attr_accessor :name

	class << self
		attr_accessor :pop

	end

	def self.speak
		"Population is #{Dog.pop}"
	end

	def initialize name
		@@count += 1
		@name = name
	end

	def speak
		"The dog has a name #{@name}"
	end
end

milu = Dog.new "Milu"
puts milu.speak
puts Dog.speak
puts Dog.pop
