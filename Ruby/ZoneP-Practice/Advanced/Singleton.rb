class Object
	def mySingleton
		class << self
			self
		end
	end
end

puts Hash.mySingleton == Hash.singleton_class
p Hash.singleton_class
