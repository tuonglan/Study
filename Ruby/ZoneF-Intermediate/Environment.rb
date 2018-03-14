#Environment filtering
puts "In parent, term = #{ENV['TERM']}"
fork do
	ENV['TERM'] = 'The black death-mask'
	puts "Now in the level-1-child, term = #{ENV['TERM']}"
	fork do
		puts "In the level-2-child, term = #{ENV['TERM']}"
	end
	Process.wait
end
Process.wait
puts "Back to parent, term= #{ENV['TERM']}"
puts $:
