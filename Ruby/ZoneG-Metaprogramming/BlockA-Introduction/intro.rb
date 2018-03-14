
class Mammal
	def speak
		puts 'This is a mammal'
	end
end


class Dog < Mammal
end

milu = Dog.new
milu.speak

module Humor
	def tickle
		"#{self} says hee, hee"
	end
end


class Grouchy
	extend Humor
end

puts Grouchy.tickle

