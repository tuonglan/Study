module BrokenMath
	refine Fixnum do
		alias_method :plus, :+
		def + value
			self.plus(value.plus 1)
		end
	end
end

module Ano
	using BrokenMath
	puts 5+1
end
