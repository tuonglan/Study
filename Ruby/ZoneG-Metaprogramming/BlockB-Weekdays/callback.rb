class Callback
	@addedMethods = []
	class << self
		def singleton_method_added name
			if name != :singleton_method_added && !@addedMethods.include?(name)
				@addedMethods << name
				m = self.singleton_method name
				self.singleton_class.send :define_method, name do |*args, &blk|
					puts "The callback of #{name} is being called..."
					m.call(*args, &blk)
				end
			end
		end

		define_method :pronounce do
			puts "Prononcing: This is class #{self}"
		end

		def speak
			puts "Speaking This is class #{self}"
		end
	end
end


class Item
	@added_methods = []
	class << self
		def singleton_method_added name
			if name != :singleton_method_added && !@added_methods.include?(name)
				@added_methods << name
				pMethod = self.singleton_method name
				self.singleton_class.send :define_method, name do |*args, &blk|
					puts "Callback functions calling..."
					pMethod.call(*args, &blk)
				end
			end
		end

		def speak
			puts "This is #{self}"
		end
	end
end
