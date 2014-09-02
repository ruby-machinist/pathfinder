require 'helper'

describe Pathfinder::MobilitySystem do
  context "by default" do
    it "should set standby to true" do
      expect(subject.standby).to eql(true)
    end
  end

  describe "move_by" do
    # Future story
  end

  describe "rotate_to" do
    # Future story
  end
end
