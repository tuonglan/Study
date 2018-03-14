require_relative 'dsl'


setup do
	puts "Setting up sky"
	@sky_height = 100
end

setup do
	puts "Setting up mountains"
	@mountains_height = 200
end


event 'The sky is falling' do
	@sky_height < 300
end

event 'It\'s geting closer' do
	@sky_height < @mountains_height
end

event 'Whoops... too late' do
	@sky_height < 0
end


# Run run run
check_event
puts "Hello World"

