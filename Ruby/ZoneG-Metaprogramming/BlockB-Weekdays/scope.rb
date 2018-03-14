require 'highline'


hl = HighLine.new
friends = hl.ask('Friends?', ->(str) {str.split(',')})
puts "You're friends with: #{friends}"
