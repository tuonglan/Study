require 'socket'
require 'thread'

server = TCPServer.open(2000)
while true
	Thread.start server.accept do |client|
		client.puts "The server time now is #{Time.now.strftime "%y%m%d - %H:%M:%S"}"
		client.puts "Closing the connection bybye"
		client.close
	end
end
