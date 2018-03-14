class Post
	attr_reader :title, :body, :comment

	def initialize(title, body, comment)
		@title = title
		@body = body
		@comment = comment
	end

	def average_word_length
		words = body.split
		words.inject(0) { |slen, word| slen += word.length} / words.count.to_f
	end

	def wordCount
		body.split.count + title.split.count + comment.split.count
	end
end
post = Post.new("Yo playa", "Sup son, this post is dope", "Do you want a piece of me?")
p post.average_word_length
