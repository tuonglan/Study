class Parent 
	def sayHello
		puts "#{self.to_s} hi #{self}"
	end
end

class Child < Parent
end

par = Parent.new
par.sayHello
puts "The super calss of #{Child.to_s} is #{Child.superclass}"


require 'gserver'
class LogServer < GServer
	def initialize
		super(12345)
	end

	def serve(client)
		client.puts getEndOfLogFile
	end

private
	def getEndOfLogFile
		File.open("/var/log/system.log") do |log|
			log.seek(-1000, IO::SEEK_END)
			log.gets
			log.read
		end
	end
end


class Person
	include Comparable
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def to_s
		"#{@name}"
	end

	def <=>(other)
		self.name <=> other.name
	end
end

p1 = Person.new("Matz")
p2 = Person.new("Guido")
p3 = Person.new("Larry")

# Compare a couple of name
if (p1 > p2)
	puts "#{p1.name}'s name > #{p2.name}'s name"
end

p [p1, p2, p3].sort
