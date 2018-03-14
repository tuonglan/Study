class Universe
	class << self
		def my_accesor *args
			args.each do |method|
				#Define the get method
				define_method method do
					instance_variable_get "@#{method.to_s}"
				end

				#Define the set method
				define_method (method.to_s + '=').to_sym do |value|
					instance_variable_set("@#{method.to_s}".to_sym, value)
				end
			end
		end
	end

	my_accesor :age

	def initialize age
		@age = age
	end
end


u = Universe.new 13
puts "The age of the universe is: #{u.age}"


module MyModule
	def self.speak
		puts "Hello, this is #{self}"
	end

	def talk
		puts "This is #{self}"
	end
end

class MyClass
	class << self
		include MyModule.singleton_class
	end
end


