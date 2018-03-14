class Account
	attr_accessor :balance
	def initialize(balance)
		@balance = balance
	end
end


class VirtualAccount
	attr_accessor :balance
	def initialize(balance)
		@balance = balance
	end
end


class Transaction
	def initialize(accountA, accountB)
		@accountA = accountA;
		@accountB = accountB;
	end

	def transfer(amount)
		debit(@accountA, amount)
		credit(@accountB, amount)
	end

	private
		def debit(account, amount)
			account.balance -= amount
		end

		def credit(account, amount)
			account.balance += amount
		end
end

savings = Account.new(1000)
checking = Account.new(2000)
virtual = VirtualAccount.new(50000)
trans = Transaction.new(checking, savings)
trans.transfer(900)
puts "The remaining of checking is: #{checking.balance}"

vTrans = Transaction.new(virtual, savings)
trans.transfer(25000)
puts "Are we a millionaire now: #{savings.balance}"

person = "Lan Do"
puts "The class of 'person' is: #{person.class}"
puts "The 'person' has the ID: #{person.object_id}"
puts "The vaue of 'person' is: #{person}"

arr = [3, 9, 10, 26, -1, 99]
arr[11] = "Sure"
arr[0, 5] = [[2,3]]
p arr
