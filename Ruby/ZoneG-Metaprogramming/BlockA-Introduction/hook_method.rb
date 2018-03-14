class Person
	code = proc {puts self}

	define_method :name do
		code.call
	end
end


class Developer < Person
	
end

lan = Developer.new
lan.name


class MyOpenStruct < Object
	def initialize(initial_values = {})
		p initial_values
		@values = initial_values
	end

	def _singleton_class
		class << self
			self
		end
	end

	def method_missing(name, *args, &block)
		if name[-1] == '='
			 basename = name[0..-2].intern
			_singleton_class.instance_exec name do |name|
				define_method name do |value|
					@values[basename] = value
				end
			end
			@values[basename] =  args[0]
		else
			_singleton_class.instance_exec name do |name|
				define_method name do
					@values[name]
				end
			end
			@values[name]
		end
	end
end

obj = MyOpenStruct.new(name: 'Lan')
obj.address = 'Gracenote'
obj.likes = 'Girls'

puts "#{obj.name} lives in #{obj.address} and likes #{obj.likes}"
