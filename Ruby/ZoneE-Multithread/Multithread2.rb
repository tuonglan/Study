count = 0
threads = []
10.times do |i|
	threads[i] = Thread.new do
		#sleep(rand(0.1))
		Thread.current["mycount"] = count
		count += 1
	end
end

threads.each {|t| t.join; print t["mycount"], ", "}
puts "Count = #{count}"
puts

threads = []
5.times do |i|
	threads << Thread.new do
		raise "Boom!" if i==2
		print "#{i}\n"
	end
end
threads.each do |t|
	begin
		t.join
	rescue RuntimeError => e
		puts "Failed: #{e.message}"
	end
end


def inc(n)
	n + 1
end

sum = 0
mutex = Mutex.new
threads = (1..10).map do
	Thread.new do
		10000.times do
			mutex.synchronize do
				temp = inc(sum)
				temp2 = temp
				sum = temp2
			end
		end
	end
end
threads.each(&:join)
p sum

result = `date`
puts result

pipe = IO.popen("-","w+")
if pipe
	pipe.puts "Get a job"
	STDERR.puts "Child says: #{pipe.gets}"
else
	STDERR.puts "Dad says: #{gets.chomp}"
	puts "OK"
end
