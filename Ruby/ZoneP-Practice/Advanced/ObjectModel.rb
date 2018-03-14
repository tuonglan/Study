class Pencil; end
p Pencil.class

p Class.class
p Class.superclass
p BasicObject.singleton_class.superclass
p BasicObject.singleton_class.class

class Cup
	private
	def empty
	end
end

class House
	def initialize area
		@area = area
	end

	def speak
		@height = 23
		"The color of the house is: #{color}"
		@rooms = 3
	end

	private
	def color
		"Blue: #{@area} square meters, #{@height} meters height, #{@rooms}"
	end
end
ronan = House.new(11)
puts ronan.speak

class Fido
	def angry
		self.sound * 3
	end

	protected
	def sound
		'woof'
	end
end
p Fido.new.angry

h = {}
class Sublime
	@fav = 'caress me down'

	def sing(obj)
		obj.instance_variable_set(:@greeting, 'mucho gusto')
		obj.instance_variable_set(:@name, 'Brad Pitt')
	end
end
s = Sublime.new
s.sing(h)
p s.instance_variables
p h.instance_variables
