
# The beyond world
pipe = IO.popen('-', 'w+')
if pipe
	pipe.puts 'Get a Job'
	STDERR.puts "Child says '#{pipe.gets.chomp}'"
else
	STDERR.puts "Dad says '#{gets.chomp}'"
	puts 'OK'
end


# Independent children

# Blocks and Subprocess
IO.popen("date") {|f| puts "The date is: #{f.gets}"u
