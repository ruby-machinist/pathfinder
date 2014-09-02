module Pathfinder
  module Interfaces
    # Simple standard wrapper - provides read_command method used by the robot
    class StandardInput
      attr_accessor :input

      # Set the input to stdin
      def initialize
        self.input = $stdin
      end

      # reads line from the stdin
      def read_command
        input.gets
      end
    end
  end
end