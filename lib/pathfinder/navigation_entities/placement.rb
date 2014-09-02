module Pathfinder
  module NavigationEntities
    # Provides storage for position and direction information
    class Placement
      attr_accessor :position, :direction

      # Sets position and direction
      def initialize(position, direction)
        @position, @direction = position, direction
      end

      # Returns position's and direction params in one array
      def to_params
        [position.x, position.y, direction.direction]
      end
    end
  end
end