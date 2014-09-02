require 'helper'

describe Pathfinder::Interfaces::FileInput do
  let(:file_path) { File.expand_path('../../../assets/test_input.txt', __FILE__) }
  subject { described_class.new(file_path) }

  describe "initialize" do
    it "should set input to a file instance" do
      expect(subject.input).to be_kind_of(File)
    end

    it "should open the file path given as a parameter" do
      expect(subject.input.path).to eq(file_path)
    end
  end

  describe "#read_command" do
    it "should return first line from the file" do
      expect(subject.read_command).to eq("MOVE\n")
    end

    it "should print the each line using stdout" do
      expect($stdout).to receive(:puts).with("MOVE\n")
      subject.read_command
    end

    context "called twice" do
      it "should return next line from the file" do
        subject.read_command
        expect(subject.read_command).to eq("LEFT\n")
      end
    end
  end
end