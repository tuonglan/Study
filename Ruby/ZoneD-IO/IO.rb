File.open("input.txt") do |file|
	while line = file.gets
		puts line
	end
end

File.foreach("input.txt") do |line|
	puts line
end

STDOUT << 99 << "Red balloons end" <<"\n"

begin
	require "socket"
	client = TCPSocket.open('127.0.0.1', 'finger')
	puts "Open socket success full"
	client.send("mysql\n",0)
	puts client.readlines
	client.close
rescue
	puts "So, something's wrong"
ensure
	puts "Luckily, We can still reach here\n"
end

require 'net/http'
h = Net::HTTP.new('www.pragprog.com', 80)
response = h.get('/titles/ruby3/programming-ruby-3')
if response.message == "OK"
	puts response.body.scan(/<img alt=".*?" src="(.*?)"/m).uniq
end
