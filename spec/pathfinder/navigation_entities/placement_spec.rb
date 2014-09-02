require 'helper'

describe Pathfinder::NavigationEntities::Placement do
  let(:position) { double('position') }
  let(:direction) { double('direction') }
  subject { described_class.new(position, direction) }

  describe "#initialize" do
    it "should set position and direction" do
      expect(subject.position).to eq(position)
      expect(subject.direction).to eq(direction)
    end
  end

  describe "#to_params" do
    subject { described_class.new(double('position', :x => 1, :y => 2), double('direction', :direction => "SOUTH")) }

    it "should return position's x, y and direction" do
      expect(subject.to_params).to eq([1, 2, "SOUTH"])
    end
  end
end
