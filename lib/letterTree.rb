# Monkey patching the shit out of String to get some LISPy first and rest stuff for recursion.
# Don't judge me.
class String
  def first
    self[0]
  end

  def rest
    self[1, length]
  end
end

class LetterTree
  attr_accessor :children
  attr_accessor :word # treated as a boolean

  def initialize(word = '')
    @children = Hash.new
    add(word)
    self.word = false
  end

  # adds the given word to the tree (works recursively with substrings)
  def add(word)
    if word.length > 0 # there was a zero length char after this, idk
      if @children[word.first] # if current letter exists in hash, add to it
	@children[word.first].add(word[1, word.length])
	@children[word.first].word = true if (word.length == 1)
      else # if the letter doesn't exist, create it
	@children[word.first] = LetterTree.new(word[1, word.length])
	@children[word.first].word = true if (word.length == 1)
      end
    end
  end

  # prints out a text representation of the current node and it's children
  # you probably want list_words
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
    return nil if word.empty?
    return nil if @children.empty? # only used once for the empty tree

    if word.length == 1
      @children[word.first] ? @children[word.first].word : nil
    else
      @children[word.first].is_word(word.rest)
    end
  end

  # does an in order traversal of the words in the tree
  def list_words(parent_string = '')
    words = Array.new
    ('A'..'Z').to_a.each do |c|
      if @children[c] != nil 
	if @children[c].word == true
	  words << parent_string + c 
	end
	if @children[c].has_children?
	  words << @children[c].list_words(parent_string + c) 
	end
      end
    end
    words.flatten
  end

end

