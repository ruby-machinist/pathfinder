module Pathfinder

  class InvalidDirectionError < PathfinderError; end

  module NavigationEntities
    # Stores direction information, provides methods for rotations
    class Direction
      # Directions in a clockwise order
      ORDERED_DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]

      # Direction unit vectors
      DIRECTION_VECTORS = {
        "NORTH" => [0, 1],
        "EAST"  => [1, 0],
        "SOUTH" => [0, -1],
        "WEST"  => [-1, 0]
      }

      attr_reader :direction

      # Sets initial direction
      def initialize(initial_direction)
        self.direction = initial_direction
      end

      # Sets direction property to the given attribute. Raises error if the given direction is not supported
      def direction=(new_direction)
        raise InvalidDirectionError unless ORDERED_DIRECTIONS.include?(new_direction)
        @direction = new_direction
      end

      # Returns new direction object rotated clockwise
      def rotate_clockwise
        rotate(1)
      end

      # Returns new direction object rotated counterclockwise
      def rotate_counterclockwise
        rotate(-1)
      end

      # Returns unit vector representing current direction
      def to_unit_vector
        DIRECTION_VECTORS[direction]
      end

      private

      def rotate(numeric_direction)
        current_direction_index = ORDERED_DIRECTIONS.index(direction)

        destination_index = (current_direction_index + numeric_direction) % ORDERED_DIRECTIONS.size
        destination_index = ORDERED_DIRECTIONS.length - 1 if destination_index < 0

        self.class.new(ORDERED_DIRECTIONS[destination_index])
      end
    end
  end
end