module Pathfinder
  # This class is only a placeholder
  class MobilitySystem
    attr_accessor :standby

    # Initialize method assumes that robot is in a standby mode - ready for driving
    def initialize
      @standby = true
    end

    # TODO: Placeholder method responsible for moving the robot
    def move_by(vector)
      self.standby = false
      # drive
      self.standby = true
    end

    # TODO: Placeholder method responsible for rotations
    def rotate_to(vector)
      self.standby = false
      # rotate
      self.standby = true
    end
  end
end