p 1.upto(Float::INFINITY).lazy.map {|x| x*x}.take(10).to_a

e = Enumerator.new do |yielder|
	[1,2,3].each do |val|
		yielder << val
	end
end
p e.next
p e.next
p e

f = Fiber.new do
	x = 0
	loop do
		Fiber.yield x
			x += 1
	end
end

puts f.resume
puts f.resume


module Enumerator
	def lax
		Lax.new(self)
	end
end


class Lax < Enumerator
	
end
