module Pathfinder
  # Reporter class is responsible for reporting robot's current placement
  class Reporter
    attr_accessor :navigation_system

    # Intialize the reported
    #
    # @param navigation [Pathfinder::NavigationSystem] navigation system instance - provides current placement info
    def initialize(navigation)
      self.navigation_system = navigation
    end

    # Reports current position by printing it to the stdout
    # Skips printing the information if robot isn't placed on a surface
    def report
      return unless navigation_system.placed?
      $stdout.puts(navigation_system.current_placement.to_params.join(','))
    end
  end
end