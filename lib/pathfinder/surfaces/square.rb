module Pathfinder
  module Surfaces
    # This class represents a square surface and it's a base fo all other square surfaces
    # Enables developer to check whether given point is on the surface
    #
    class Square
      attr_accessor :side_length

      # Initializes square surface object, sets side length
      def initialize(dimension)
        @side_length = dimension
      end

      # Returns true if given position is inside the square
      def position_on_surface?(position)
        width_and_height_range = (0..side_length)
        width_and_height_range.cover?(position.x) && width_and_height_range.cover?(position.y)
      end
    end
  end
end