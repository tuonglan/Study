class Dog
	
protected
	def getName
		"Memo"
	end
end

def Dog::sayHello
	puts "Hello, this is class Dog"
end


mem = Dog.new
Dog::sayHello
