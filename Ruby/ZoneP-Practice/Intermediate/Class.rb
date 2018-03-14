class Bottle
	DRANK = "Lemme hit that"
	@@volume = 3000

	def self.getDrank
		DRANK
	end

	def metaclass
		class << self
			self
		end
	end
end

def Bottle.kind
	"Alcohol"
end

p Bottle::DRANK
p Bottle.getDrank
p Bottle::getDrank

bottle = Bottle.new
def bottle.whatkind
	'Who cares?'
end
p bottle.metaclass
p bottle.metaclass.instance_methods
puts "------------------------------------------"
p bottle.singleton_methods
p Bottle.singleton_methods


class Array
	def downcase
		self.map do |ele|
			ele.class == String ? ele.downcase : ele
		end
	end
end

lst = ["HELLO", 'wHOW a cat', 25]
p lst.downcase
p Bottle.kind

puts "------------------------------------------"
class Mammal
	def self.about
		"We are living creatures with hair"
	end
end

class Dog < Mammal; end

puts Dog.about


class Person
	def initialize(firstName, lastName)
		@firstName = firstName
		@lastName = lastName
	end

	def fullName
		"#{@firstName} #{@lastName}"
	end
end

class Doctor < Person
	def fullName
		"Dr. #{super}"
	end
end

drNo = Doctor.new('Cate', 'Archer')
puts drNo.fullName


class Book
	def initalize(args)
		@pages = args.fetch(:page)
		@title = args.fetch(:title)
	end
end

class Textbook
	def initialize(args)
		@chapters = args.fetch(:chapters)
	end
end

txtBook = Textbook.new({chapters: 20})
#txtBook02 = Textbook.new({page: 31, title: 'Into The Wild'})
