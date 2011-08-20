require "letterTree.rb"
require "board.rb"

class Location
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class WordFinder
  def initialize
    @board = Board.new
    @words = LetterTree.new
    @stack = []
  end

  def traverse
    l = Location.new(0,0)
    (0..3).each do |j|
      (0..3).each do |k|
	l.x = j
	l.y = k
        puts "#{l.x}, #{l.y}"
      end
    end
  end
end

# wf = WordFinder.new
# wf.traverse
