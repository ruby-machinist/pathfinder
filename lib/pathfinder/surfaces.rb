module Pathfinder
  # Surfaces module contains various types of surfaces you can use
  # (currently square and square_table are implemented)
  module Surfaces
    autoload :Square, 'pathfinder/surfaces/square'
    autoload :SquareTable, 'pathfinder/surfaces/square_table'
  end
end