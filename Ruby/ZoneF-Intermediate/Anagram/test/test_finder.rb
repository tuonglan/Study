require 'minitest/autorun'
require 'shoulda'
require_relative '../lib/finder'

class TestFinder < Minitest::Test
	context 'signature' do
		{'cat' => 'act', 'act' => 'act', 'wombat' => 'abmotw'}.each do |word, sign|
			should "be #{sign} for #{word}" do
				assert_equal sign, Anagram::Finder.signature_of(word)
			end
		end
	end

	context 'lookup' do
		setup do
			@finder = Anagram::Finder.new ['cat', 'wombat']
		end

		should "return word if word given" do
			assert_equal ['cat'], @finder.lookup('cat')
		end
		should "return word if signature given" do
			assert_equal ['cat'], @finder.lookup('act')
			assert_equal ['cat'], @finder.lookup('cta')
		end
		should 'return nil if no_word matches anagram' do
			p @finder.lookup('wibble')
			assert_nil @finder.lookup 'wibble'
		end
	end
end
