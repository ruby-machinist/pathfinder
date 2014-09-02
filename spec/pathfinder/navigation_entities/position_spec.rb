require 'helper'

describe Pathfinder::NavigationEntities::Position do
  subject { described_class.new(1,2) }

  describe "#initialize" do
    it "should set x and y arguments" do
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(2)
    end
  end

  describe "#add" do
    subject { described_class.new(1,1) }

    it "should add vector to the current position" do
      expect(subject.add([3,4]).x).to eq(4)
      expect(subject.add([3,4]).y).to eq(5)
    end

    it "should not accept invalid vectors" do
      # invalid size
      expect { subject.add([1, 1, 1]) }.to raise_error(Pathfinder::InvalidVectorSumError)
      # invalid type
      expect { subject.add("1, 1") }.to raise_error(Pathfinder::InvalidVectorSumError)
    end
  end

  describe "#minus" do
    subject { described_class.new(5,5) }

    it "should subtract given position form the current position and return a vector" do
      expect(subject - subject.class.new(1,2)).to eq([4, 3])
    end

    it "should not accept non-point objects" do
      # invalid type
      expect { subject - ([1, 1]) }.to raise_error(Pathfinder::InvalidPointSubtractionError)
    end
  end
end
