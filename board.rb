class Die
  attr_accessor :face
  @letters

  def initialize(letters)
    @letters = letters
    @face = rand(6)
  end

  def getLetter
    @letters[face]
  end

  def shake
    @face = rand(6)
  end
end

class BoardNode
  @die
  attr_accessor :position
  # position should be an enumeration starting at 0 = top
  # 		1     2            3        4             5         6           7        8
  # attr_accessor :top, :top_right, :right, :bottom_right, :bottom, :bottom_left, :left, :top_left

  def initialize(letters)
    @die = Die.new(letters)
    @position = []
  end
end

class Board
  def initialize
    @b = []
    (0..15).each do |i|
      @b[i] = BoardNode.new(%w(a b c d e f))
    end
    set_up_network
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
    puts @b.index(@b[6])
  end

  def find_a_path
    s = []
    n = @b[0]
    s.push(n)
    puts s
    while (no_mas == false)
      no_mas = true
      (0..7).each do |i|
        # if the node at i isn't null
	# and
	# s doesn't include that node
        if (n.position[i] != nil and s.include?(n.position[i]))
	  n = n.position[i]
	  puts "found one #{n}"
	  s.push(n)
	  no_mas = false
	end
      end
    end
    puts s
  end
end

b = Board.new
b.find_a_path

