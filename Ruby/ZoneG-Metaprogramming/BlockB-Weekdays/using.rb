module Using
	def self.using resource, &block
		begin
			block.call
		rescue Exception => e
			raise
		ensure
			resource.dispose if resource
		end
	end
end
