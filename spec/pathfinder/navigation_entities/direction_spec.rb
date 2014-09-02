require 'helper'

describe Pathfinder::NavigationEntities::Direction do
  subject { described_class.new("NORTH") }

  describe "#initialize" do
    it "should set given direction" do
      expect(subject.direction).to eq("NORTH")
    end

    it "should not accept invalid directions" do
      expect { described_class.new("INVALID") }.to raise_error(Pathfinder::InvalidDirectionError)
    end
  end

  describe "#rotate_clockwise!" do
    context "when current direction is NORTH" do
      subject { described_class.new("NORTH") }

      it "should change direction to EAST" do
        expect(subject.rotate_clockwise.direction).to eq("EAST")
      end
    end

    context "when current direction is EAST" do
      subject { described_class.new("EAST") }

      it "should change direction to SOUTH" do
        expect(subject.rotate_clockwise.direction).to eq("SOUTH")
      end
    end

    context "when current direction is SOUTH" do
      subject { described_class.new("SOUTH") }

      it "should change direction to WEST" do
        expect(subject.rotate_clockwise.direction).to eq("WEST")
      end
    end

    context "when current direction is WEST" do
      subject { described_class.new("WEST") }

      it "should change direction to NORTH" do
        expect(subject.rotate_clockwise.direction).to eq("NORTH")
      end
    end
  end

  describe "#rotate_counterclockwise!" do
    context "when current direction is NORTH" do
      subject { described_class.new("NORTH") }

      it "should change direction to WEST" do
        expect(subject.rotate_counterclockwise.direction).to eq("WEST")
      end
    end

    context "when current direction is WEST" do
      subject { described_class.new("WEST") }

      it "should change direction to SOUTH" do
        expect(subject.rotate_counterclockwise.direction).to eq("SOUTH")
      end
    end

    context "when current direction is SOUTH" do
      subject { described_class.new("SOUTH") }

      it "should change direction to EAST" do
        expect(subject.rotate_counterclockwise.direction).to eq("EAST")
      end
    end

    context "when current direction is EAST" do
      subject { described_class.new("EAST") }

      it "should change direction to NORTH" do
        expect(subject.rotate_counterclockwise.direction).to eq("NORTH")
      end
    end
  end

  describe "#to_vector" do
    context "when current direction is NORTH" do
      subject { described_class.new("NORTH") }

      it "should return [0,1]" do
        expect(subject.to_unit_vector).to eq([0,1])
      end
    end

    context "when current direction is EAST" do
      subject { described_class.new("EAST") }

      it "should return [1,0]" do
        expect(subject.to_unit_vector).to eq([1,0])
      end
    end

    context "when current direction is SOUTH" do
      subject { described_class.new("SOUTH") }

      it "should return [0,-1]" do
        expect(subject.to_unit_vector).to eq([0,-1])
      end
    end

    context "when current direction is WEST" do
      subject { described_class.new("WEST") }

      it "should return [-1,0]" do
        expect(subject.to_unit_vector).to eq([-1,0])
      end
    end
  end
end
