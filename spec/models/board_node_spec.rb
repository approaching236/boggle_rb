require 'spec_helper'

describe BoardNode do
  let(:board_node) { Fabricate(:board_node) }
  let(:bn) { Fabricate(:board_node) }

  it "should respond to position" do
    board_node.should respond_to :position
  end

  it "should have a letter" do
    board_node.should respond_to :letter
  end

  it "should have letter return the right letter" do
    board_node.die.letters[0] = "a"
    board_node.die.face = 0
    board_node.letter.should == "a"
  end

  it "should return an unused connected node" do
    top = 0
    board_node.position[top] = bn
    board_node.unused_nodes.should include top
  end

  it "should probably return an unused connected node with char" do
    top = 0
    board_node.position[top] = bn
    1000.times do
      bn.die.letters = Array.new(6) { (rand(122-97) + 97).chr }.join.upcase
      break if board_node.unused_nodes_with('A').include? top
    end
    board_node.unused_nodes_with('A').should include top
  end

end
