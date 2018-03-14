fbWords = Fiber.new do
	File.foreach("testfile.txt") do |line|
		line.scan(/\w+/) do |word|
			Fiber.yield word.downcase
		end
	end
end

wCounter = Hash.new(0)
while word = fbWords.resume
	wCounter[word] +=1
end

wCounter.sort.each {|key, value| print "#{key}: #{value} "}
puts

require 'net/http'
page = %w( www.rubycentral.com slashdot.org www.google.com )
threads = []
page.each do |address|
	puts "Creating thread for: #{address}"
	threads << Thread.new(address) do |url|
		h = Net::HTTP.new(url, 80)
		print "Fetching: #{url} \n"
		resp = h.get('/')
		print "Got #{url}: #{resp.message}\n"
	end
end

puts "Starting thread..."
threads.each {|thr| thr.join}
