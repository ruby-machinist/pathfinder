require 'helper'

describe Pathfinder::Surfaces::SquareTable do
  subject { described_class.new }

  describe "by default" do
    it "should set side length to 5" do
      expect(subject.side_length).to eq(5)
    end
  end

  describe "inheritance" do
    it "should be a kind of square" do
      expect(subject).to be_kind_of(Pathfinder::Surfaces::Square)
    end
  end
end