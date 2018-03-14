require 'rexml/document'

class GEDCOMParser
	attr_reader :dataStr

	def initialize
		@dataStr = {}
	end

	def parse filename
		doc = REXML::Document.new "<gedcom/>"
		stack = [doc.root]

		File.readlines(filename).each do |line|
			lineArr = analyzeLine line
			
			# Go the the right scope
			level = lineArr[0].to_i
			while (level+1) < stack.size
				stack.pop
			end

			parent = stack.last
			val = nil
			if lineArr[1] =~ /@.+@/
				val = parent.add_element lineArr[2]
				val.attributes['id'] = lineArr[1]
			else
				val = parent.add_element lineArr[1]
				val.text = lineArr[2] 
			end

			stack.push val
		end

		doc
	end

	private
	def analyzeLine line
		data = /(\d+) (@?\w+@?) (.+)/.match line
		data[1..-1]
	end
end


parser = GEDCOMParser.new
doc = parser.parse 'GEDCOM.txt'
File.open('GEDCOMXML.txt', 'w') do |file|
	doc.write(file,4)
end

