require 'test/unit'

def explore_array method 
	code = "['a', 'b', 'c'].#{method}"
	puts "Evaluationg: #{code}"
	eval code
end


def add_checked_attribute(klass, attribute, &block)
	klass.class_eval do
		define_method attribute do
			instance_variable_get "@#{attribute}"
		end

		define_method "#{attribute}=".to_sym do |value|
			if block.call value
				instance_variable_set("@#{attribute}", value)
			else
				raise RuntimeError.new 'Invalid value'
			end
		end
	end
end

module AttrChecked
	def self.included klass
		klass.extend AttrCheckedMethods
	end

	module AttrCheckedMethods
		def att_checked attribute, &block
			define_method attribute do
				instance_variable_get "@#{attribute}"
			end

			define_method "#{attribute}=".to_sym do |value|
				raise 'Invalid value' unless block.call value
				instance_variable_set("@#{attribute}", value)
			end
		end
	end
end

class Life
	include AttrChecked
	att_checked :age do |age|
		if age
			age <= 101
		else
			false
		end
	end
end

class TestCheckedAttribute < Test::Unit::TestCase
	def setup
		@dog = Life.new
	end

	def test_accepts_valid_value
		@dog.age = 11
		assert_equal 11, @dog.age
	end

	def test_refuses_nil_value
		assert_raises RuntimeError, 'Invalid attribute' do
			@dog.age = nil
		end
	end

	def test_refuses_false_value
		assert_raises RuntimeError, 'Invalid attribute' do
			@dog.age = 102
		end
	end
end
