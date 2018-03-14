def five(a, b, c, *rest)
	puts "I've just passed #{a} #{b} #{c} and the rest #{rest.inspect}"
end

rest = [11, 12, 13]
five(1, 2, *rest)

puts %x{ls}
