arr = Array.new()
arr.push(String.new("fun"))
arr.push(String.new("games"))
p arr

class Dog
	def speak
		"Ruff Ruff"
	end
end
dog = Dog.new
puts dog.speak


class Fish
	@@count = 0

	def self.count
		@@count
	end

	def self.count= c
		@@count = c
	end
	
	def self.overview
		"Fish are animals that live in the sea"
	end
end
puts Fish.overview
Fish.count = 3
puts "Curent fish #{Fish.count}"


class Lion
	attr_reader :name

	def initialize(name)
		@name = name
	end
end
lion = Lion.new("Simba")
puts lion.name
leo  = Lion.new(20)
puts leo.name


module Clueless
	def funny
		"AS IF?"
	end
end

class Actress
	include Clueless
end
puts Actress.new.funny

class BaseballPlayer
	attr_accessor :hits, :walks, :at_bats

	def initialize(hits, walks, at_bats)
		@hits, @walks, @at_bats = hits, walks, at_bats
	end

	def batting_average()
		@hits.to_f/@at_bats
	end

	def on_base_percentage()
		(@hits + @walks).to_f/@at_bats
	end
end
mike = BaseballPlayer.new(51, 37, 17)
puts mike.on_base_percentage()


module MathHelpers
	def self.exponent(number, exponent)
		number ** exponent
	end
end

class Calculator
	include MathHelpers
	def self.square_root(number)
		MathHelpers::exponent(number, 0.5)
	end
end
puts Calculator.square_root(2)
puts MathHelpers::exponent(3,2)
