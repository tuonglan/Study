p "***"
p self
class SnoopDogg
	p self
end

class Jake
	@@classVar = 7
	@classInVar = 77
	attr_accessor :inVar

	def self.classVar
		@@classVar
	end

	class << self
		attr_accessor :classInVar
	end

	def initialize
		@inVar = 777
	end
end

boy = Jake.new
puts boy.inVar
puts Jake.classInVar
puts Jake.classVar


module FuncSet
	x = "------------"
	puts x
	def instanceMethod
		puts "It's a instance level method"
		p self
	end

	def self.moduleLevelMethod
		puts "It's f**king good"
		p self
	end
end

class Divergent
	include FuncSet
end

alice = Divergent.new
alice.instanceMethod
Divergent.extend FuncSet
Divergent.instanceMethod


module Outsider
	def self.included(base)
		base.extend ClassMethods
	end

	module ClassMethods
		def classMethod
			puts "Wow, thisis the class method"
			puts self
		end
	end

	def instanceMethod
		puts "This is instance method"
	end
end

class Earth
	include Outsider
end
Earth.classMethod

define_method(:speak) do
	alice.instanceMethod
end
speak


