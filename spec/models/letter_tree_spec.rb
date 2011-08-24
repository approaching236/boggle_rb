require 'spec_helper'

describe LetterTree do
  
  let(:lt) { Fabricate(:letter_tree) }

  it "should begin empty" do
    lt.children.empty?.should be_true
  end

  it "should add a word" do
    lt.add("BAT")
    lt.children.empty?.should be_false
  end

  it "should return a word that was added to it" do
    lt.add("BAT")
    lt.add("BATTER")
    lt.is_word("BAT").should be_true
    lt.is_word("BATT").should be_false
    lt.is_word("BATTER").should be_true
    lt.is_word("BAZ").should be_false
  end

  it "should return an array of words" do
    lt.add("BAT")
    lt.list_words.should include "BAT"
  end

end

