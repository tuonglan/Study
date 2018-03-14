def fiboUpTo(max)
	i1, i2 = 1, 1
	while i1 < max
		yield i1
		i1, i2 = i2, i1 + i2
	end
end

fiboUpTo(1000) {|f| print f, " "}
puts

def myFind(arr)
	arr.each do |each|
		return each if yield each
	end
end

puts myFind [1,3, 7, 9, 11, 20, 33] {|x| x*x > 100}

puts [1,5,3,9,12].inject(0) {|sum, ele| sum + ele}


shortEnum = [1,2,3,4].to_enum
longEnum = ('a'..'z').to_enum
loop do
	puts "#{shortEnum.next}: #{longEnum.next}"
end


result = []
['a', 'b', 'c', 'd'].each_with_index{|item, index| result << {item => index}}
p result


enumGood = (1..10).to_enum(:each_slice, 3)
p enumGood.to_a
p (1..10)


triangularNumber = Enumerator.new do |yielder|
	number = 0
	count = 1
	loop do
		number += count
		count += 1
		yielder.yield number
	end
end

5.times {puts triangularNumber.next}


class ProcExample
	def passInBlock(&action)
		@storedProc = action
	end

	def runBlock(*params)
		@storedProc.call params
	end
end

procInstance = ProcExample.new
procInstance.passInBlock {|number, name| puts "The input number is: #{number} and name: #{name}"}
procInstance.runBlock(101, "Lan Do")

def nTimes(num)
	lambda {|n| num * n}
end
p1 = nTimes(1000)
puts p1.call(21)


def powerGenerator
	value = 1
	lambda {value += value}
end

pGen1 =  powerGenerator
pGen2 = powerGenerator
print pGen1.call; print " "; puts pGen1.call
puts pGen2.call

def myIf condition, thenClause, elseClause
	if condition
		thenClause.call 4, 3
	else
		elseClause.call
	end
end

5.times do |val|
	myIf val < 3 , -> a, b { puts "Small baby: #{a}:#{b}"}, -> {puts "Big enough"}
end

p2 = -> a, *b, &block do
	puts "a = #{a}"
	puts "b = #{b}"
	block.call
end

p2.call(3, 2, 7 , 1, 12) {puts "Hello World"}

def myFunc param1, param2, *prList
	if param1
		puts "Okie, this never happens"
	else
		param2.call *prList
	end
end

myFunc 4 < 2, -> a, b {puts "Value is #{a} and #{b}"}, 11, 12
