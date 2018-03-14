class XMLNode
	attr_accessor :values, :tag, :attributes, :parent

	def initialize tag
		@values = []
		@tag = tag
		@attributes = {}
		@parent = nil
	end

	def insertValue value
		@values << value
	end
end


class XMLTre
	
end
