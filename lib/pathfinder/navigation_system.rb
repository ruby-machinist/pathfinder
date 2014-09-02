require 'pathfinder/navigation_entities/position'
require 'pathfinder/navigation_entities/direction'
require 'pathfinder/navigation_entities/placement'

module Pathfinder
  # Navigation class is responsible for storing and updating robot's position and direction,
  # passing movement requests to the mobility system and skipping instructions dangerous for the robot
  # (prevents toy from driving outside given surface based)
  class NavigationSystem
    attr_reader :current_placement, :surface, :mobility_system
    attr_accessor :target_placement

    # Initializes navigation system
    #
    # @param surface [Pathfinder::Surfaces] surface object - provides position_on_surface? method used
    #   to make a decision about passing movement request to the mobility system
    # @param mobility_system [Pathfinder::MobilitySystem] object responsible for the actual movement of the robot
    #   (in this project it's rather a placeholder for a future implementation)
    def initialize(surface, mobility_system)
      @surface = surface
      @mobility_system = mobility_system
    end

    # Returns true if robot is already placed on the given surface (current placement information is available)
    def placed?
      !current_placement.nil?
    end

    # This method calculates target position based on current location and direction of the robot.
    # Will ask mobility system to move the robot one unit forward in the direction it is currently facing
    # if it is already placed on a surface and if target destination isn't outside the surface
    def move
      # Do not continue if robot isn't placed
      return cancel_action("Robot isn't placed on the surface yet") unless placed?

      # Calculate target position. Cancel processing the method if it's outside current surface
      target_position = current_placement.position.add(current_placement.direction.to_unit_vector)
      return cancel_action("Robot can't drive outside the surface") unless surface.position_on_surface?(target_position)

      # Set the current placement, calculate movement vector and pass it ot the mobility system.
      self.target_placement = NavigationEntities::Placement.new(target_position, current_placement.direction)
      mobility_system.move_by(target_position - current_placement.position)

      # Current mobility system is just a placeholder, so it's always executed
      if mobility_system.standby
        # Update information about current location.
        # TODO: Refactor this part when a real mobility system will be plugged in
        update_placement(target_placement)
      end
    end

    # Places robot on the surface on (x, y) position and sets direction to one of the four main directions supported
    # by the corresponding class.
    # Does not allow to place robot outside the current surface.
    def place(x, y, direction)
      # Set target position. Cancel processing the method if it's outside current surface
      target_position = NavigationEntities::Position.new(x, y)
      return cancel_action("Robot can't be placed outside") unless surface.position_on_surface?(target_position)

      # Set direction of the robot. Store it in the placement object.
      target_direction = NavigationEntities::Direction.new(direction)
      self.target_placement = NavigationEntities::Placement.new(target_position, target_direction)

      # Update information about current location.
      update_placement(target_placement)
    end

    # If robot is already on the current surface, rotates robot clockwise using mobility system
    def right
      return cancel_action("Robot isn't placed on the surface yet") unless placed?

      target_direction = current_placement.direction.rotate_clockwise
      rotate(target_direction)
    end

    # If robot is already on the current surface, rotates robot counterclockwise using mobility system
    def left
      return cancel_action("Robot isn't placed on the surface yet") unless placed?

      target_direction = current_placement.direction.rotate_counterclockwise
      rotate(target_direction)
    end

    private

    def rotate(target_direction)
      self.target_placement = NavigationEntities::Placement.new(current_placement.position, target_direction)

      mobility_system.rotate_to(target_direction.to_unit_vector)

      # current mobility system is just a placeholder, so it's always executed
      if mobility_system.standby
        update_placement(target_placement)
      end
    end

    def cancel_action(reason)
      false
    end

    def update_placement(placement)
      @current_placement = placement
    end
  end
end