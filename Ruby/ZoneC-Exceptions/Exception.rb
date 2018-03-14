require 'open-uri'
page = 'podcasts'
fileName = "#{page}.html"
webPage = open("http://pragprog.com/#{page}")
output = File.open(fileName, "w")

begin
	while line = webPage.gets
		output.puts line
	end
	output.close
rescue Exception
	STDERR.puts "Failed to download #{page}: #{$!}"
	output.close
	File.delete(fileName)
	raise
end
