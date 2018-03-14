class A
	define_method :method_a do |x, &blk|
		y = blk.call x
		puts "Value of y is: #{y}"
	end

	def method_b x
		y = yield x
		puts "Value of y is: #{y}"
	end
end

a = A.new
a.method_b(13) {|x| x*x}
a.method_a(15) {|x| x*x}


class B
	def send name, *args, &blk
		@block = blk if blk
		super
	end

	def method_c x
		puts "The input number is #{x}"
	end
end


class NewRuby
	@newMethodList = []

	class << self
		def my_def name, &block
			define_method(name, &block)
		end

		def method_added name
			super
			if (name != :yield) && (!@newMethodList.include? name)
				@newMethodList << name
				puts "New method added: #{name}"
				puts "Trying to wrap method #{name} with new #{name}"
				pOldMethod = self.instance_method name
				define_method name do |*args, &blk|
					@block = blk
					p blk
					pOldMethod.bind(self).call(*args, &blk)
				end
			end
		end
	end

	def yield *args
		@block.call *args
	end

	my_def :method_a do |x|
		puts "Input new value is #{x}"
	end

	my_def :method_b do |x|
		y = yield x
		puts "Output value is #{y}"
	end
end



