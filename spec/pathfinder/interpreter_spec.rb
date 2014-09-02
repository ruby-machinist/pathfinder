require 'helper'

describe Pathfinder::Robot::Interpreter do
  before do
    @robot = Pathfinder::Robot.new
  end

  describe "#interpret_command" do

    context "when the given command is a valid one-segment command" do
      it "should call corresponding robot's method on appropriate module" do
        Pathfinder::Robot::Interpreter::VALID_REPORTER_COMMANDS.each do |command|
          expect(@robot.reporter).to receive(command.downcase)
          @robot.interpret_command(command)
        end

        Pathfinder::Robot::Interpreter::VALID_LOCATION_COMMANDS.each do |command|
          expect(@robot.navigation_system).to receive(command.downcase)
          @robot.interpret_command(command)
        end
      end

      context "starting or ending with space characters" do
        it "should still call corresponding robot's method" do
          Pathfinder::Robot::Interpreter::VALID_REPORTER_COMMANDS.each do |command|
            expect(@robot.reporter).to receive(command.downcase)
            @robot.interpret_command("  #{command}   ")
          end

          Pathfinder::Robot::Interpreter::VALID_LOCATION_COMMANDS.each do |command|
            expect(@robot.navigation_system).to receive(command.downcase)
            @robot.interpret_command("  #{command}   ")
          end
        end
      end
    end

    context "when the given command is a valid multi-segment command" do
      it "should call corresponding robot's method on appropriate module" do
        expect(@robot.navigation_system).to receive(:place).with(10, 20, "NORTH")
        @robot.interpret_command("PLACE 10,20,NORTH")
      end

      context "with space characters between arguments, at the beggining or the end of the command" do
        it "should still call corresponding robot's method" do
          expect(@robot.navigation_system).to receive(:place).with(10, 20, "NORTH")
          @robot.interpret_command("  PLACE  10 ,  20  ,   NORTH  ")
        end
      end
    end

    context "when the given command is invalid" do
      it "should not raise error" do
        expect {@robot}.to_not raise_error
        @robot.interpret_command("INVAID")
      end
    end
  end
end
