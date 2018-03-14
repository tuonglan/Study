module Mam
	def hello
		'Hey Hey'
	end
end

class Person
	include Mam
end
p Person.instance_methods.include? :hello


module Dollar
	def self.included(base)
		base.extend Cash
	end	
	
	def speak
		"Dollar is the strongest monetary asset in the world"
	end

	module Cash
		def exchange
			"Changing to cash"
		end
	end
end

class Money
	class << self
		include Dollar
	end
end
p Money.speak
p Money.singleton_class.exchange
p Money.singleton_methods
p Money.singleton_class.singleton_methods


module Job
	def assassin
		"I'm an assassin in assassin Creed"
	end
	module_function :assassin
end

class Company; include Job; end
p Job.assassin

module Cat; end
module Dog; end
class Feline
	extend Cat
	class << self
		include Dog
	end
end
p Feline.singleton_class.ancestors

x = 'I am an variable'
Mo = Module.new do
	define_method(:silly) do
		x
	end
	module_function :silly
end
p Mo.silly


class Amon
	private
	def method_missing(name, *args)
		args.unshift(name.to_s).join
	end
end
p Amon.new.destroy('everything', ' you see')

class Calculator
	private
	def method_missing(name, *args)
		args.inject(:+)
	end
end
p Calculator.new.accumulate(1,2,3,4)


class Monkey
	private
	def method_missing(name, *args)
		super unless name == :full_name
		args.join(" ")
	end
end
Monkey.new.full_name


class Redmine
	private
	def method_missing(name, *args)
		super unless name == :battlefield
		'This is a shit movie'
	end

	def respond_to_missing?(name, include_private = false)
		name == :battlefield || super
	end
end

clerk = Redmine.new
puts clerk.respond_to? :battlefield
puts clerk.method :battlefield


class Book
	def initialize(title, author)
		@title, @author = title, author
	end

	private
	def method_missing(name, *args)
		var = "@#{name}"
		super unless instance_variables.include?(var.to_sym)
		instance_variable_get(var)
	end
end
b = Book.new('The Intelligent Investor', 'Benjamin Graham')
p b.title




