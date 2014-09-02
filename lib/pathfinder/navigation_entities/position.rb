module Pathfinder
  class InvalidVectorSumError < PathfinderError; end
  class InvalidPointSubtractionError < PathfinderError; end

  module NavigationEntities
    # This class provides a storage and methods for manipulation information about position on a 2-dimension surface
    class Position
      attr_accessor :x, :y

      # Sets initial position
      def initialize(x, y)
        @x, @y = x, y
      end

      # Returns a new location by moving current position by the given vector.
      def add(vector)
        raise InvalidVectorSumError unless vector.kind_of?(Array) && vector.size == 2
        self.class.new(x + vector[0], y + vector[1])
      end

      # Returns vector by subtracting given position from the current one.
      def -(position)
        raise InvalidPointSubtractionError unless position.kind_of?(Position)
        [x - position.x, y - position.y]
      end
    end
  end
end