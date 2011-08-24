class Die
  attr_accessor :face
  attr_accessor :letters

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
