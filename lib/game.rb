require 'board.rb'
require 'letterTree.rb'

def play_mode(b)
  @lt = DictionaryHandler.new.load_dic

  word = "I am sure there is a better way to do this"
  puts "Not currently timed. All valid words will be added to dic"
  while !word.empty?
    word = gets.chomp.upcase
    valid = b.valid_path_exists?(word) if !word.empty?
    puts "#{word} #{@lt.is_word(word) ? "is a word" : "wasn't a word"} and #{valid ? "is valid" : "isn't valid"}" if !word.empty?
    @lt.add(word) if valid
  end

  dump(@lt)
end

b = Board.new
b.shake
# b.show_board

DictionaryHandler.new.list_mode(b)

