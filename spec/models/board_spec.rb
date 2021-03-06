require 'spec_helper'

describe Board do
  
  let(:board) { Board.new }

  it "should set up connections going left and right" do
    # left/right
    (0..15).each do |i|
      if i % 4 == 0
	board.b[i].position[2].should be board.b[i+1]
	board.b[i].position[6].should be_nil
      end
      if (i+1) % 4 == 0
	board.b[i].position[2].should be_nil
	board.b[i].position[6].should be board.b[i-1]
      end
    end
  end
    
  it "should set up connections going up and down" do
    (0..15).each do |i|
      if i < 4
	board.b[i].position[0].should be_nil
	board.b[i].position[4].should be board.b[i+4]
      end
      if i >= 12
	board.b[i].position[0].should be board.b[i-4]
	board.b[i].position[4].should be_nil
      end
    end
  end

  it "should set up connections going up and down" do
    (0..15).each do |i|
      if i < 4
	board.b[i].position[0].should be_nil
	board.b[i].position[4].should be board.b[i+4]
      end
      if i >= 12
	board.b[i].position[0].should be board.b[i-4]
	board.b[i].position[4].should be_nil
      end
    end
  end

  it "should set up connections - diagonal" do
    (0..11).each do |i| #don't include bottom row
      if i < 4 || i % 4 == 0
        board.b[i].position[7].should be_nil
	if i != 3 && i != 12
	  board.b[i].position[3].should be board.b[i+5]
	elsif
	  board.b[i].position[3].should be_nil
	end
      end
    end
  end

  it "should set up connections + diagonal" do
    (0..11).each do |i| #don't include bottom row
      if i > 11 || i+1 % 4 == 0
        board.b[i].position[3].should be_nil
	if i != 3 && i != 12
	  board.b[i].position[7].should be board.b[i-5]
	elsif
	  board.b[i].position[7].should be_nil
	end
      end
    end
  end

  it "should clear all used flags with unmark_used_nodes" do
    board.b[5].used = true
    board.unmark_used_nodes
    board.b[5].used.should be_nil
  end

  it "should find some arbitrary words consistantly" do
    100.times do
      arbitrary_word = 
	board.b[5].letter + 
	board.b[6].letter + 
	board.b[9].letter + 
	board.b[10].letter + 
	board.b[7].letter + 
	board.b[2].letter
      lt = LetterTree.new
      lt.add(arbitrary_word)
      board.report_words_in_lt(lt).should include arbitrary_word
    end

    100.times do
      arbitrary_word = 
	board.b[9].letter + 
	board.b[14].letter + 
	board.b[13].letter + 
	board.b[10].letter
      lt = LetterTree.new
      lt.add(arbitrary_word)
      board.report_words_in_lt(lt).should include arbitrary_word
    end
    
    100.times do
      arbitrary_word = 
	board.b[4].letter + 
	board.b[5].letter + 
	board.b[10].letter + 
	board.b[11].letter
      lt = LetterTree.new
      lt.add(arbitrary_word)
      board.report_words_in_lt(lt).should include arbitrary_word
    end

    100.times do
      arbitrary_word_prefix = 
	board.b[4].letter + 
	board.b[5].letter + 
	board.b[10].letter + 
	board.b[11].letter
      arbitrary_word = 
	board.b[4].letter + 
	board.b[5].letter + 
	board.b[10].letter + 
	board.b[11].letter + 
	board.b[6].letter + 
	board.b[9].letter
      lt = LetterTree.new
      lt.add(arbitrary_word_prefix)
      lt.add(arbitrary_word)
      board.report_words_in_lt(lt).should include arbitrary_word_prefix
      board.report_words_in_lt(lt).should include arbitrary_word
    end
  end

end

