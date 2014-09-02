require 'helper'

describe Pathfinder::Reporter do
  let(:surface) { Pathfinder::Surfaces::SquareTable.new }
  let(:mobility_system) { Pathfinder::MobilitySystem.new }
  let(:navigation_system) { Pathfinder::NavigationSystem.new(surface, mobility_system) }
  subject { described_class.new(navigation_system) }

  context "#initialize" do
    it "should store given navigation system" do
      expect(subject.navigation_system).to eql(navigation_system)
    end
  end

  describe "#report" do
    context "when robot is already placed on a surface" do
      before do
        subject.navigation_system.place(3, 4, "SOUTH")
      end

      it "should send to the standard output x, y and direction of the current placement" do
        expect($stdout).to receive(:puts).with("3,4,SOUTH")
        subject.report
      end
    end

    context "if robot isn't placed on a surface yet" do
      it "should not generate output" do
        expect($stdout).to_not receive(:puts)
        subject.report
      end
    end
  end
end
