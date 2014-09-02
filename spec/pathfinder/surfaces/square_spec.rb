require 'helper'

describe Pathfinder::Surfaces::Square do
  let(:side_length) { 5 }
  subject { described_class.new(side_length) }

  describe "#initialize" do
    it "should set side_length" do
      expect(subject.side_length).to eq(side_length)
    end
  end

  describe "#position_on_surface?" do
    context "when given position is inside the square" do
      before do
        @position_on_surface = Pathfinder::NavigationEntities::Position.new(0, 0)
      end
      it "should return true" do
        expect(subject.position_on_surface?(@position_on_surface)).to eq(true)
      end
    end

    context "when given position is outside the square" do
      before do
        @position_below = Pathfinder::NavigationEntities::Position.new(0, -1)
        @position_above = Pathfinder::NavigationEntities::Position.new(0, subject.side_length + 1)
        @position_before = Pathfinder::NavigationEntities::Position.new(-1, 0)
        @position_after = Pathfinder::NavigationEntities::Position.new(subject.side_length + 1, 0)
      end
      it "should return false" do
        expect(subject.position_on_surface?(@position_below)).to eq(false)
        expect(subject.position_on_surface?(@position_above)).to eq(false)
        expect(subject.position_on_surface?(@position_before)).to eq(false)
        expect(subject.position_on_surface?(@position_after)).to eq(false)
      end
    end
  end
end