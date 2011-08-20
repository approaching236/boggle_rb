require 'spec_helper'

describe BoardNode do
  let(:board_node) { Fabricate(:board_node) }

  it "should respond to position" do
    board_node.should respond_to :position
  end

  it "should have a current letter" do
    board_node.should respond_to :current_letter
  end

  it "should have current_letter return the right letter" do
    board_node.die.letters[0] = "a"
    board_node.die.face = 0
    board_node.current_letter.should == "a"
  end

end
