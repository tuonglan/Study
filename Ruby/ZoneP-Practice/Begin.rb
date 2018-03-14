puts 15.between?(12,18)
#0.step(100, 5) {|number| puts number.to_f}
puts ?b.ord
puts 120.chr
puts "foobar".sub("foo", "goo")
puts "This is a tes".sub(/^../, "Hello")
puts "This is a test".sub(/..$/, "Bye")

"abcxyz".scan(/./) {|c| print "#{c} "}; puts
"mys test".scan(/\w\w/) {|pair| puts pair}
"The car costs 1000 and the cat costs 50".scan(/\d+/) {|num| printf "#{num} "}; puts
"This is a test".scan(/[aeiou]/) {|num| printf "#{num} "}; puts
puts ["Word", "Play", "Fun"].join ","
puts "This is a joke".split
p [1, 3, 4, 7].map {|num| num + 3}
puts [].empty?
puts [1,3,7].include?('y')
p [1, 3, 4, 5][0..1].join('-')

animals = {cat: "Feline Animal", dog: "Canine Animal"}
p animals.keys
hList = {a: 100, b: 50, c: 75}
p hList.delete_if {|key, value| value > 50}
("A".."Z").each {|letter| print "#{letter} "}; puts
p "Bob".to_sym

letters = ("a".."z").to_a
vowels = %w{a e i o u}
p letters.delete_if {|ch| vowels.include?(ch)}

puts 1000_000_000
puts (1...5).include?(4.99)
puts rand()
puts "Hello" << "World"

p 2.step(12, 2)
