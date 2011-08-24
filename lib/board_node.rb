class BoardNode
  attr_accessor :position, :die, :used

  def initialize(letters)
    @die = Die.new(letters)
    @position = []
    @used = nil
  end

  # Returns an array of positions that contain char
  #   doesn't return board index
  def unused_nodes_with(char)
    # puts unused_nodes
    # puts position[unused_nodes.first].letter
    # s = unused_nodes.delete_if { |node| position[node].letter == char }
    s = []
    (0..7).each do |i|
      if position[i] && !position[i].used
        s << i if position[i].die.getLetter == char
      end
    end
    s
  end

  # Returns an array of unused neighbors
  #   doesn't return board index
  def unused_nodes
    s = []
    (0..7).each do |i|
      if position[i] && !position[i].used
        s << i
      end
    end
    s
  end

  def letter
    @die.getLetter
  end
end

