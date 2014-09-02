require 'helper'

describe Pathfinder::Interfaces::StandardInput do

  describe "by default" do
    it "should set input to $stdin" do
      expect(subject.input).to eq($stdin)
    end
  end

  describe "#read_command" do
    before :each do
      @input  = StringIO.new("MOVE\n")
      subject.input = @input
    end

    it "should return entered value" do
      expect(subject.read_command).to eq("MOVE\n")
    end
  end
end