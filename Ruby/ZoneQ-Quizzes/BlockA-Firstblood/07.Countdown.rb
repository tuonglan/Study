class StackPushError < Exception
end


class ExprStack
	class << self
		attr_accessor :operators
	end
	@operators = ['+', '-', '*', '/']

	def initialize
		@stack = []
	end

	def tryPush op
		rt = true
		if ExprStack.operators.include? op
			b, a = @stack.pop, @stack.pop
			if (not a.is_a? Integer) || (not b.is_a? Integer)
				rt = false
			end
			if (op == '/')
				if (b == 0) || (a % b != 0)
					rt = false
				end
			end
			if (op == '-')
				if (a - b <= 0)
					rt = false
				end
			end

			@stack << a
			@stack << b
		end
		rt
	end

	def push op
		# If this is an operator, make the calculation
		if ExprStack.operators.include? op
			b, a = @stack.pop, @stack.pop
			#print "\t---- Performing '#{a} #{op} #{b}' ----"
			@stack <<  a.send(op.to_sym, b)
		else
			@stack << op
		end
	end

	def pop; @stack.pop end
	def backup; @stack.dup end
	def restore stack; @stack = stack end
	def getDistance target; (@stack.last - target).abs end

	def toString; "#{@stack}" end
end


class Countdown
	attr_accessor :postfixStack

	def self.generateNumList
		bigFour = [25, 50, 75, 100]
		ls = []
		ls << bigFour[Random.rand(4)]
		5.times {ls << 1 + Random.rand(10)}
		ls
	end

	def initialize
		@postfixStack = []
	end

	def findCombination(numList, target)
		@numList = numList
		@calStack = ExprStack.new
		@distance = 1.0/0.0

		# Insert the first number to the list
		head = @numList.shift
		@calStack.push(head)
		@postfixStack.push(head)
		combinationRecursive target
		@numList.unshift head

		@distance
	end

	private
	def combinationRecursive target
		len = @numList.length
		len.times do |index|
			num = @numList.delete_at(index)		# Withdraw a number from the num list
			@calStack.push(num)
			@postfixStack.push(num)
			combinationRecursive target

			ExprStack.operators.each do |op|
				if @calStack.tryPush op
					bk = @calStack.backup

					#print @calStack.toString		# Print the stack
					@calStack.push op
					@postfixStack.push op
					#print "\t"; p @calStack.toString	
	
					# Use heuristic search to get the next move
					newDistance = @calStack.getDistance target

					# If the combination is found, test the result
					if newDistance == 0
						value = ExprStack.new
						@postfixStack.each do |ele|
							value.push ele
						end
						puts "#{@postfixStack.to_s} = #{value.toString}" 
					end
					if newDistance < @distance
						@distance = newDistance
					end
					combinationRecursive target

					@postfixStack.pop
					@calStack.restore bk
				end
			end

			@postfixStack.pop
			@calStack.pop
			@numList.insert(index, num)			# Insert it back to the num list
		end
	end
end


begin
	puts "Begining..."
	countdown = Countdown.new
	numList = Countdown.generateNumList
	target = 100 + Random.rand(900)

	result = countdown.findCombination(numList, target)
	puts "The list of numbers are: #{numList}"
	puts "The distance is: #{result} compared to target: #{target}"
rescue Exception => e
	puts e.message
rescue
	puts 'Some weird error occurs, who knows?'
end
