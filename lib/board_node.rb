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
    s = []
    (0..7).each do |i|
      if position[i] and !position[i].used and position[i].die.getLetter == char
        s.push(i)
      end
    end
    return s
  end

  # Returns an array of unused neighbors
  #   doesn't return board index
  def unused_nodes
    s = []
    (0..7).each do |i|
      if position[i] and !position[i].used
        s.push(i)
      end
    end
    return s
  end

  def letter
    @die.getLetter
  end
end

