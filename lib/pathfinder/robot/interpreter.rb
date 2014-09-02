module Pathfinder
  class Robot
    # Interpreter provides a method responsible for user's input interpretation
    # It calls corresponding internal robot's methods for a valid command
    # and does nothing if the command is invalid.
    module Interpreter
      VALID_REPORTER_COMMANDS = ["REPORT"]
      VALID_LOCATION_COMMANDS = ["MOVE", "LEFT", "RIGHT"]

      def interpret_command(command)
        command.chomp!
        command.strip!

        case command
          when *VALID_LOCATION_COMMANDS
            self.navigation_system.send(command.downcase)
          when *VALID_REPORTER_COMMANDS
            self.reporter.send(command.downcase)
          else
            if command.match(/PLACE\s+\-?\d+\s*,\s*\-?\d+\s*,\s*(NORTH|SOUTH|WEST|EAST)/)
              method, x, y, direction = *command.split(/[\s,]+/)
              self.navigation_system.place(x.to_i, y.to_i, direction)
            end
        end
      end
    end
  end
end