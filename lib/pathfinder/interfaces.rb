module Pathfinder
  # Interfaces module contains various types of interfaces you can use
  # to communicate with the robot
  module Interfaces
    autoload :StandardInput, 'pathfinder/interfaces/standard_input'
    autoload :FileInput, 'pathfinder/interfaces/file_input'
  end
end