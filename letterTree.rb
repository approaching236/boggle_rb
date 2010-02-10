class LetterTree
	@children
	attr_accessor :word # treated as a boolean

  def initialize(word = '')
		@children = Hash.new
	  add(word)
	end

	# adds the given word to the tree (works recursively with substrings)
	def add(word)
 		if word.length > 0 # there was a zero length char after this, idk
      if @children[word[0,1]] # if current letter exists in hash, add to it
	      @children[word[0,1]].add(word[1, word.length])
				@children[word[0,1]].word = true if (word.length == 1)
	    else # if the letter doesn't exist, create it
	      @children[word[0,1]] = LetterTree.new(word[1, word.length])
				@children[word[0,1]].word = true if (word.length == 1)
	    end
		end
	end

	# prints out a text representation of the current node and it's children
	def current_children
	  p @children
	end

	def has_children?
	  @children.size != 0
	end

	# returns the letterTree object that is the value of the key given
	# ie lt['c'] will return the node that is referenced by 'c'
	def [](i)
	  @children[i]
	end

	# Digs through the tree to return if this string is a word in the tree
	# more of a test. This isn't really how it should be used. 
	# though it could be used to avoid premature optimization
	def is_word(word)
	  lt = @children
	  word.each_char { |c|
		  if lt[c]
			  lt = lt[c]
			else
				return nil
			end
		}
		lt.word
	end
end

#lt = LetterTree.new('omg')
#lt.add('oa')
#puts lt.is_word('omg')
#puts lt.is_word('om')
#puts lt.is_word('omgf')
