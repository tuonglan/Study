require 'minitest/autorun'
require 'shoulda'
require_relative '../lib/options'

class TestOptions < Minitest::Test
	context "specifying no dictionary do" do
		should "return default" do
			opts = Anagram::Options.new ['someword']
			assert_equal Anagram::Options::DEFAULT_DICTIONARY, opts.dictionary
		end
	end

	context "specifying a dictionary do" do
		should "return default" do
			opts = Anagram::Options.new ['-d', 'mydict', 'someword']
			assert_equal opts.dictionary, 'mydict'
		end
	end

	context "specifying words and no dictionary" do
		should "return default" do
			opts = Anagram::Options.new ['word1', 'word2']
			assert_equal opts.words_to_find, ['word1', 'word2']
		end
	end

	context "specifying words and dictionary" do
		should "return default" do
			opts = Anagram::Options.new ['-d', 'mydict', 'word1', 'word2']
			assert_equal opts.words_to_find, ['word1', 'word2']
		end
	end
end
