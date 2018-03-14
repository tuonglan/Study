module Speak
	def speak
		puts "#{self} is speaking"
	end
end


class Mammal
	self.include Speak
	class << self
		include Speak

		class << self
			def Superfunc
				puts "This is superfunc with #{self}"
			end

			class << self
				def SSFunc
					puts "This is SSFunc of #{self}"
				end
			end
		end
	end
end

p Mammal.class
p Mammal.singleton_class
p Mammal.singleton_class.Superfunc
p Mammal.singleton_class.singleton_class


puts '-----------------------------------'
p Mammal.singleton_methods
p Mammal.singleton_class.singleton_methods
p Mammal.singleton_class.singleton_class.singleton_methods
p Mammal.instance_method(:speak)

puts '----------------- Chap 2 ----------------'
class Human
	puts "Self in class is #{self}"
	define_method :eat do 
		puts "#{self} is eating"
	end
end

Human.instance_eval do
	def run
		puts "#{self} is running"
	end

	puts "Self in instance_eval is #{self}"
	define_method :speak do |msg|
		puts "#{self} is speaking #{msg}"
	end
end

neon = Human.new
neon.speak "Hello World"
neon.eat
Human.run
