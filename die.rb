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

class Board
  
	def initialize
		@board = Array.new(4) { Array.new(4) }
		
		load_defaults()
	end

  def load_defaults
    (0..3).each do |j|
      (0..3).each do |k|
        @board[j][k] = Die.new(%w{a b c d e f})
			end
		end
	end

	# Josh should refactor this
	def show_board
    (0..3).each do |j|
      (0..3).each do |k|
        print @board[j][k].getLetter
				print ' '
			end
			puts
		end
	end
end

b = Board.new
b.show_board
