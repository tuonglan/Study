module SecondLevelModule
	def self.included kclass
		kclass.extend ClassMethods
	end

	def second_level_instance_method
		puts "This is #{self}: second_level_instance_method"
	end

	module ClassMethods
		def second_level_class_method
			puts "This is #{self}: second_level_class_method"
		end
	end
end

module FirstLevelModule
	def self.included kclass
		kclass.extend ClassMethods
	end

	def first_level_instance_method
		puts "This is #{self}: first_level_instance_method"
	end

	module ClassMethods
		def first_level_class_method
			puts "This is #{self}: first_level_class_method"
		end
	end

	include SecondLevelModule
end

class BaseClass
	include FirstLevelModule
end

