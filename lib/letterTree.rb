class LetterTree
attr_accessor :children
attr_accessor :word # treated as a boolean

def initialize(word = '')
  @children = Hash.new
  add(word)
end

def load_dic
  if File.exists?("dic") and !File.zero?("dic")
    puts "using old dic"
    File.open('dic') do |f|  
      @lt = Marshal.load(f)  
    end
  else
    puts "creating new letter tree object"
    @lt = LetterTree.new
  end
  @lt
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
  tmp = @children[word[0,1]] if @children[word[0,1]]
  word[1, word.length].each_char { |c| # I forget why exactly I used an iterative solution. It had something to do with those first checks
    if tmp and tmp.children
      tmp = tmp.children[c] 
    else
      return nil 
    end
    tmp.word if tmp
  }
end

# does an in order traversal of the words in the tree
def list_words(parent_string)
  ('A'..'Z').to_a.each do |c|
		if @children[c] != nil 
			puts parent_string + c if @children[c].word != nil
			@children[c].list_words(parent_string + c) if @children[c].has_children?
		end
	end
end

end

