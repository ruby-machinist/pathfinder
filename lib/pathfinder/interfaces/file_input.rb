module Pathfinder
  module Interfaces
    # Simple file input wrapper - provides read_command method used by the robot
    class FileInput
      attr_accessor :input

      # Set input property to a file
      def initialize(file_path)
        self.input = File.new(file_path, 'r')
      end

      # reads line from the file
      def read_command
        line = self.input.gets
        $stdout.puts line
        line
      end
    end
  end
end