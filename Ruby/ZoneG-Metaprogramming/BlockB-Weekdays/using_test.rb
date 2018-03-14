require 'test/unit'
require_relative 'using'


class TestUsing < Test::Unit::TestCase
	class Resource
		def dispose
			@dispose = true
		end

		def dispose?
			@dispose
		end
	end

	def test_disposes_of_resources
		r = Resource.new
		Using.using(r) {}
		assert r.dispose?
	end

	def test_disposes_of_resources_in_case_of_exception
		r = Resource.new
		assert_raises Exception do
			Using.using(r) {raise Exception}
		end
		assert r.dispose?
	end

end
