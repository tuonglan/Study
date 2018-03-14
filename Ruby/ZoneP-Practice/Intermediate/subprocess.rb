require 'pty'

PTY.spawn 'ruby run.rb' do |r, w, pid|
	begin
		r.sync
		r.each_line {|line| puts "#{Time.now.strftime("%M:%S")} - #{line}"}
	rescue Errno::EIO => e
		puts "ERROR: #{e}"
	ensure
		::Process.wait pid
	end
end

puts "Hello World"

