require 'test/unit'

numArray = [1, 2, 5, 9, 11]
numArray.push(99)

p numArray

aniDic = 
{
	'dog' => 'mamal',
	'crocodie' => 'reptile',
	'bee' => 'insect'
}

humDic =
{
	head: 'bone',
	leg: 'meat'
}

p humDic


def wordsFromString(str)
	str.downcase.scan(/[\w']+/)
end

p wordsFromString("Hello Word, I'm Lan Do")


def countWordsInString(str)
	counter = Hash.new(0)
	wordsFromString(str).each { |word| counter[word] += 1}
	counter
end

p countWordsInString("Hello is a good way of saying good morning, good night and good afternoon")


rawText = File.read("input.txt")
wordList = countWordsInString(rawText)
sortedWordList = wordList.sort_by {|word, count| count}
puts ("The top five is:")
5.times do |i|
	puts "Word: #{sortedWordList[-i-1][0]}, \t\tCount: #{sortedWordList[-i-1][1]}"
end
puts ""

def tryYield(n)
	n.times do |i|
		rt = yield i
		printf("%d ",rt)
	end
	puts ""
end

tryYield(5) {|i| i*i}


class TestWordsFromString < Test::Unit::TestCase
	def testEmptyString
		assert_equal([], wordsFromString(""))
		assert_equal([], wordsFromString("   "))
	end

	def testSingleWord
		assert_equal(["cat"], wordsFromString("cat"))
		assert_equal(["cat"], wordsFromString("   cat   "))
	end

	def testManyWords
		assert_equal(%w{the cat sat on the mat}, wordsFromString("The cat sat on the mat"))
	end

	def testIgnoresPunctuation
		assert_equal(%w{the cat's mat}, wordsFromString("<the!> cat's, -mat-"))
	end
end
