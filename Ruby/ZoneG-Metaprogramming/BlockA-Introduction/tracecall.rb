module TraceCall
	def self.included kclass
		kclass.instance_methods(false).each do |method|
			wrap(kclass, method)
		end

		def kclass.method_added method
			unless @already_called
				@already_called = true
				TraceCall.wrap(self, method)
				@already_called = false
			end
		end
	end

	def self.wrap kclass, method
		kclass.instance_eval do 
			method_object = instance_method(method)
			define_method method do |*args, &block|
				puts "===> #{self} calling #{method} with input #{args}"
				rt = method_object.bind(self).call(*args, &block)
				puts "<=== #{method} of #{self} returned #{rt}"
			end
		end
	end
end

class Human
	include TraceCall

	def speak msg
		puts "#{self} is speaking #{msg}"
	end
end

rog = Human.new
rog.speak "Hello World"
