MIN_WORD_LENGTH = 3

class Board
  attr_accessor :b

  def initialize
    @b = []
    default_board
    set_up_network
  end

  def default_board
    @b[0] = BoardNode.new(%w(A O B B J O))
    @b[1] = BoardNode.new(%w(I T Y D S T))
    @b[2] = BoardNode.new(%w(N E G W H E))
    @b[3] = BoardNode.new(%w(O U T I C M))

    @b[4] = BoardNode.new(%w(V D L Y R E))
    @b[5] = BoardNode.new(%w(N E E S I U))
    @b[6] = BoardNode.new(%w(V E T W H R))
    @b[7] = BoardNode.new(%w(Z L N R H N))

    @b[8] = BoardNode.new(%w(D I E L X R))
    @b[9] = BoardNode.new(%w(O O T T A W))
    @b[10] = BoardNode.new(%w(T T L R E Y))
    @b[11] = BoardNode.new(%w(S O E I S T))

    @b[12] = BoardNode.new(%w(N A E G A E))
    @b[13] = BoardNode.new(%w(A C H O P S))
    @b[14] = BoardNode.new(%w(H I M N U Q))
    @b[15] = BoardNode.new(%w(K P S F F A))
  end

  def set_up_network
    # top/bottom
    (0..11).each do |i| # don't include bottom row
      @b[i].position[4] = @b[i+4]
      @b[i+4].position[0] = @b[i]
    end
    # left/right
    (0..15).each do |i|
      if (i+1)%4 != 0 # don't include right column
        @b[i].position[2] = @b[i+1]
        @b[i+1].position[6] = @b[i]
      end
    end
    # +
    (0..11).each do |i| #don't include bottom row
      if (i+1)%4 != 0 # don't include right column
        @b[i].position[3] = @b[i+5]
        @b[i+5].position[7] = @b[i]
      end
    end
    # -
    (0..11).each do |i| #don't include bottom row
      if i%4 != 0 # don't include left column
        @b[i].position[5] = @b[i+3]
        @b[i+3].position[1] = @b[i]
      end
    end
  end

  def show_board
    (0..15).each do |i|
      print @b[i].die.getLetter
      print " "
      print "\n" if ((i+1)%4 == 0)
    end
  end
  
  # Cool, but unnessesary
  def show_board_usage
    puts
    (0..15).each do |i|
      print 0 if @b[i].used == nil
      print 1 if @b[i].used != nil
      print " "
      print "\n" if ((i+1)%4 == 0)
    end
    puts
  end

  # This takes a string, and returns if there is a legal path that contains that string
  def valid_path_exists?(word)
    if (word.length < MIN_WORD_LENGTH)
      puts "Words must be greater than three letters long"
      return nil
    end

    tail = word[1, word.length]
    (0..15).each do |i|
      if (@b[i].die.getLetter.casecmp(word[0,1]) == 0) # if the letter matches the first in word
        @b[i].used = true
        return true if dfs(@b[i], tail) # need to check all instances of that letter
        @b[i].used = nil
      end
      unmark_used_nodes 
    end
    return nil
  end

  def shake(n)
    # swap dice n times
    n.times do
      a, b = rand(16), rand(16)
      tmp = @b[a].die
      @b[a].die = @b[b].die
      @b[b].die = tmp
    end

    # shake each die
    (0..15).each do |i|
      @b[i].die.shake
    end
  end

  def report_words_in_lt(lt)
    words = []
    (0..15).each do |i|
      # puts lt[@b[i].letter] this returns the letter_node with that letter

      current_letter_node = lt[@b[i].letter]
      if current_letter_node
	words += report_search(current_letter_node, @b[i], @b[i].letter)
      end
      unmark_used_nodes
    end
    words.uniq.sort
  end

  def unmark_used_nodes
    (0..15).each do |i|
      @b[i].used = nil
    end
  end


  protected

    # This is for report_words_in_lt, as it just does the base case for
    # all of the possible entry points for the graph. this method 
    # completes the recursive step
    def report_search(letter_node, board_node, parent_string)
      board_node.used = true
      tmp_words = []

      neighbors = board_node.unused_nodes
      neighbors.each do |n|
	# board_node has a neighbor with a letter that is a child
	# of the letter_node if this is statement is true
	if letter_node[board_node.position[n].letter] 
	  tmp_string = parent_string + board_node.position[n].letter
	  tmp_words.push tmp_string if letter_node[board_node.position[n].letter].word
	  tmp_words += report_search(letter_node[board_node.position[n].letter], board_node.position[n], tmp_string)
	end
      end

      board_node.used = nil
      tmp_words
    end

    # shouldn't be used directly
    def dfs(current, word)
      if word.empty?  # word has been found as valid path
	current.used = true
	# show_board_usage
	return true
      end

      current.used = true
      head = word[0,1]
      tail = word[1, word.length]
      unused_nodes = current.unused_nodes_with(head)

      while !unused_nodes.empty?
	unused = unused_nodes.pop
	return true if dfs(current.position[unused], tail)
      end
      current.used = nil
      return nil
    end
end
