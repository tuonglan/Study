module M1; end

module M2
	include M1
	def method2
		puts "This is M2:method2"
	end
end

module M3
	def method3
		method2
	end
end

class A
	def initialize
		@x = "This is A: #{self.class}"
	end
	def my_method
		puts @x
	end
end


class B < A
	def a_method
		@x = 'This is B'
		my_method
	end
end


class C
	include M2
	include M3
	def method_c
		method3
	end
end
