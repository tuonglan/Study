def counter
	n = 0;
	return lambda {n += 1}
end

a = counter
puts a.call
puts a.call

b = counter
puts b.call
