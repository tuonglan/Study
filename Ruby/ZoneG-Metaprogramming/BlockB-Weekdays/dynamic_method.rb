require 'benchmark'

class MyClass
	define_method :my_method do |arg|
		arg * 3
	end

	def method_missing(method, *args)
		if method.to_s.include? 'method'
			puts "You've call method #{method}"
			puts "But that method is not available"
		else
			super
		end
	end
end


module Mathematics
	refine Module do
		def const_missing const_name
			puts "Warning: depricated #{const_name}"
			puts "Using: New:#{const_name} instead"
		end
	end

	refine Integer do
		def factorial
			(1..self).reduce :* || 1
		end

		def fact
			sum = 1
			self.times {|i| sum *= i+1}
			sum
		end
	end
end


class Calculation
	using Mathematics
	MAX = 2000
	#Benchmark.bmbm do |bm|
	#	bm.report('Factorial by fold') do 
	#		MAX.times {|idx| idx.factorial}
	#	end
	#	bm.report('Factorial by loop') do
	#		MAX.times {|idx| idx.fact}
	#	end
	#end
	class << self
		puts self
		define_method :say_something do
			puts self
			puts "Is it still class method? "
		end

	private
		def my_define_method name, &block
			puts "Received #{name} & #{block}"
		
		end
	end

	define_method :estimate do |arg|
		puts "Estimating #{arg}"
	end

	my_define_method :calculate do |arg|
		puts "Calculating #{arg}"
	end
end

class Roulette
	def method_missing(name, *arg)
		person = name.to_s.capitalize
		4.times do
			number = rand(10) + 1
			puts "#{number}..."
		end
		number = rand(10) + 1
		puts "#{person} got number #{number}"
	end
end


class HyperClass
	def method_missing(name, *arg)
		if name.to_s.include? '='
			puts "Method missing: #{name}, creating a new one"
			self.class.send(:attr_accessor, name.to_s.chop.to_sym)
			self.send(name, *arg)
		else
			super
		end
	end

	def make_method
		class << self
			puts self
			define_method  :new_method do |arg|
				puts "The new method prints: #{arg}"
			end
		end
	end
end



