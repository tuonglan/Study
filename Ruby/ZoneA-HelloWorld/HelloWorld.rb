def sayGoodnight(name)
	result = "Good night #{name.capitalize}"
	return result
end

puts sayGoodnight("bob")

a = [1, 'cat', 3.14]
puts "The first element is #{a[0]}"
a[3] = nil
puts "The array is now #{a.inspect}"
b = %w{ ant bee cat dog elk }
puts "The array b is #{b.inspect}"

instSection = 
{
	:cello	=> 'string',
	:clarinet => 'woodwind',
	:drum => 'percussion',
	:oboe => 'woodwind',
	:trumpet => 'brass',
	:violin => 'string',
}

puts "The value of cello is #{instSection[:cello]}"
p instSection['guitar']

animalSection = 
{
	mammal: 'Animal with breast',
	reptile: 'Animal with strong skin',
	insect: 'Animal without spine',
	bird: 'Animal with flying ability'
}

puts "The speciality of bird is #{animalSection[:bird]}"

index = 17
if index > 10
	puts "Big Big big"
elsif	index == 9
	puts "Good value"
else
	puts "Okie, fine"
end

myText = 'Python is wierd'
rExp = /Perl|Python/
if myText =~ rExp
	puts"Yes, the text include #{myText}"
end

line = 'I am learning Python and Perl'
puts line.sub(/Python|Perl/, 'Ruby')

def whoSayWhat
	puts "Starting the procedure..."
	yield("Mary", "helo")
	yield("Peter", "good morning")
	puts "Procedure ends."
end
whoSayWhat {|person, phrase| puts "#{person} says #{phrase}" }

%w{cat, dog, horse, }.each { |name| print name, " "}
puts " "

5.times { |n| print n}
('a'..'s').each {|char| print char}
puts ""

puts "You gave #{ARGV.size} arguments"
p ARGV






















