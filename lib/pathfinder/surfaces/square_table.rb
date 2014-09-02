module Pathfinder
  module Surfaces
    # This class represents a square table surface with default dimension 5x5
    class SquareTable < Square
      def initialize(side_length = 5)
        super(side_length)
      end
    end
  end
end