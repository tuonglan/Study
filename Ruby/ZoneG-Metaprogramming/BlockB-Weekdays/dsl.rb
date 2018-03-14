init_event = lambda do
	events = []
	setups = []

	Kernel.send :define_method, :event do |des, &block|
		events << {:des => des, :cond => block}
	end

	Kernel.send :define_method, :setup do |&setup|
		setups << setup
	end

	Kernel.send :define_method, :check_event do
		events.each do |event|
			setups.each {|setup| setup.call}
			puts "ALERT: #{event[:des]}" if event[:cond].call
		end
	end
end
init_event.call

def m_event description, &block
	@events << {:description => description, :condition => block}
end

def m_setup &block
	@setups << {:setup => block}
end

@events = []
@setups = []


def m_check_event
	@events.each do |event|
		@setups.each {|setup| setup[:setup].call}
		puts "ALERT: #{event[:description]}" if event[:condition].call
	end
end

