a = [1, 2, 3]
b = ['a', 'b', 'c']
a.each do |first|
	b.each {|second| print "#{first}#{second} "} 
end
puts

p Array.new(3) {Array.new(3) {""}}

x = []
a.each do |first|
	b.each {|second| x << ([first] << second)}
end
p x
p a.zip(b)
p (a.zip(b)).flatten

y = {}
a.each_with_index do |nu, index|
	y[nu] = b[index]
end
p Hash[a.zip(b)]

c = [["Matt", "plumber", "USA"], ["Phil", "baker", "England"]]
y = []
p c.map {|name, occupation| "Name: #{name} Occupation: #{occupation}"}

d = [["row", 3], ["your", 1], ["boat", 1]]
p d.map {|word, times| (Array.new(times) {word}).join(" ")}.join(" ")

e = [1,2,3,4,5,6,7]
p e.select {|x| x > 3}
puts e.pop
p e.inject(:+)

pro = Proc.new {|a, b| a * b}
puts pro.call(7, 11)

def breakout(sessionName)
	Proc.new {|presenter| puts "#{sessionName} #{presenter}"}
end
pr = breakout("Proramming")
pr.call("Powers")

arr = ["a", "b"]
p arr.map(&:upcase)

puts "Bob".center(40, "*")
puts "Bob".rjust(40, "*")
p arr.unshift("Nice")

5.step(100, 5) {|nu| print "#{nu} "};puts;

p (1..20).group_by {|num| (num % 3 == 0)? "3-devidable" : "3-undevidable" }

class Fixnum
	def echo
		puts self
	end
end
(1..3).each(&:echo)

p (1..10).select {|elem| elem.even?}.map {|elem| elem *3}
p Array.new(5) {rand(1..10)}
e.shift(3)
p e

a = [1, 2, 3, 4]
p a[5] != nil ? a[5] : "cats"
puts defined?(xx)

def binarySearch(array, value, startIndex = 0, endIndex = array.length - 1)
	puts "startIndex is #{startIndex}, endIndex is: #{endIndex}"
	while startIndex < endIndex
		index = (startIndex + endIndex)/2
		if value == array[index]
			return value
		elsif value > array[index]
			return binarySearch(array, value, index+1, endIndex)
		else
			return binarySearch(array, value, startIndex, index - 1)
		end
	end
	"Value not found"
end
p binarySearch([35,11, 27, 1, 9, 5, 33, 17], 33)

(1..100).each {|num| print "#{num.to_s} "}; puts
p (1..100).map(&:to_s)

Array.new(10) {Array.new(10) {rand(2) == 0 ? 'A' : 'D'}}.each {|arr| p arr}

p matchingPart = "123.12.1234".match(/(\d{3}).(\d{2}).(\d{4})/)
p "123.12.1234".sub(/(\d{3}).(\d{2}).(\d{4})/, '\1-\1-\2\2-\3')

def add(num1, num2)
	num3 = num1 + num2
	binding.pry
end

puts (1..100).inject(:*)
arr = %w(What is the longest word in this array?)
puts arr.inject {|longestWord, word| word.length > longestWord.length ? word : longestWord}

p (1..100).map {|num| num if (num % 7 == 0) && (num % 10 == 0)}.compact
arr = [[0,1,2], [3,4,5], [6,7,8]]
p (0..2).map {|col| arr.map {|row| row[col]}}

#x, y = gets.chomp.split.map(&:to_i)
#puts x

arr = %w(apple Bear matt Aardvark phat)
p arr.sort_by(&:downcase)
hs = {bills: 65, bobs: 42, franks: 89, johns: 5}
p hs.sort_by {|_, val| val}
p hs
