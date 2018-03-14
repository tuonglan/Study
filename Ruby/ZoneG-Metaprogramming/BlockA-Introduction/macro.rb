class AttrLogger
	def self.attr_logger name
		attr_reader name
		define_method "#{name}=" do |value|
			puts "Assigning #{value} to #{name}"
			instance_variable_set("@#{name}", value)
		end
	end
end


class Mammal < AttrLogger
	attr_logger :age
end

cat = Mammal.new
cat.age = 5
puts cat.age


module GeneralLogger
	def log msg
		puts Time.now.strftime("%H:%M:%S ") + msg
	end

	# The class's method to be extend
	module ClassMethods
		def attr_logger name
			attr_reader name
			define_method "#{name}=" do |value|
				log "Assigning #{name} of class #{self} to #{value}"
				instance_variable_set("@#{name}", value)
			end
		end
	end

	# Make the extend statement for the including class
	def self.included(host_class)
		host_class.extend ClassMethods
	end

end


class Human
	include GeneralLogger
	attr_logger :height
end
nean = Human.new
nean.height = 1.6

def MyStruct *params
	Class.new do
		attr_accessor *params
		def initialize hash
			hash.each do |key, value|
				instance_variable_set("@#{key}", value)
			end
		end
	end
end

Person = MyStruct :name,:address, :likes
lan = Person.new(name: "Lan Do", address: "Gracenote Inc.", likes: "Learning")
p lan
