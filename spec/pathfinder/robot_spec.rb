require 'helper'

describe Pathfinder::Robot do
  describe "defaults" do
    it "should use stdin interface by default" do
      expect(subject.interface.input).to eq($stdin)
    end

    it "should use table surface by default" do
      expect(subject.surface).to be_kind_of(Pathfinder::Surfaces::SquareTable)
    end
  end

  describe "#initialize" do
    let(:interface) {double('interface')}
    let(:surface) {double('surface')}
    subject { described_class.new(interface, surface) }

    it "should set interface to the given value" do
      expect(subject.interface).to eq(interface)
    end

    it "should set surface to the given value" do
      expect(subject.surface).to eq(surface)
    end

    it "should initialize reporter object" do
      expect(subject.reporter).to be_kind_of(Pathfinder::Reporter)
    end

    it "should initialize placement manager object" do
      expect(subject.navigation_system).to be_kind_of(Pathfinder::NavigationSystem)
    end

    it "should initialize mobility system" do
      expect(subject.mobility_system).to be_kind_of(Pathfinder::MobilitySystem)
    end
  end

  describe "#play" do
    it "should use the given interface to read commands until EOF is given" do
      expect(subject.interface).to receive(:read_command)
      subject.play
    end
  end
end
