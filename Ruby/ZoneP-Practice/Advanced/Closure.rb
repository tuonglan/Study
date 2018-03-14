x = 'Sir'
y = 'mix a lot'
pr = Proc.new do
	"#{x} #{y}"
end


class Sword
	def initialize prg
		p prg.call
	end
end

Sword.new pr

l = 2
pr = Proc.new {|x| x*x}
h = { me: 'So f**king happy'}
h.instance_eval do
	z =4
	p pr.call(z)
end
p pr.call(l)

b = binding
def hi bdg
	bdg.local_variable_set(:l, 101)
	bdg.local_variable_get(:h)
end
p hi(b)
p l
p eval('"#{h}"', b)


first = 'Speed'
second = 'Racer'
class Motivation
	def speak
		eval('"Go #{first} #{second}"', TOPLEVEL_BINDING)
	end
end
p Motivation.new.speak



