require 'pathfinder/robot/interpreter'
require 'pathfinder/reporter'
require 'pathfinder/navigation_system'
require 'pathfinder/mobility_system'

module Pathfinder
  # = Robot
  #
  # Robot is a toy class which simulates functionality of a simple robot
  #
  # It consists of
  #         ______
  #        |::::::| Interface modules responsible for reading user's input,
  #        `------
  #           |
  #           |
  #           |                     .-' \
  #           |                  .-'     \
  #        .-------------------'       .-
  #        | [A -> B]          |    .-`  Interpreter module - translates user's input into robot's methods
  #        |    |              |-.-'
  #        |    V              |
  #        | [X10Y01FN]        |         Navigation module - keeps current placement info, position and direction
  #        |    |              |
  #        |    V              |
  #        | [.''...]-----     |         Surface analysis module - makes a decision whether robot should move or not
  #      .-`--------------`-.--'
  #      |             .-----`o------.
  #    .-|-.         .-|-.         .-|-.
  #   |  o  |       |  o  |       |  o  |   And mobility module - makes the actual move
  #    `._.'         '._.'         `._.'
  #
  #
  #
  class Robot
    include Pathfinder::Robot::Interpreter

    attr_reader :interface, :surface
    attr_accessor :reporter, :navigation_system, :mobility_system

    # Initializes Robot instance
    #
    # @param interface [Pathfinder::Interfaces::StandardInput] interface instance - provides read_command method
    # @param surface [Pathfinder::Surface] surface object - table 5x5 by default
    def initialize(interface = Interfaces::StandardInput.new, surface = Surfaces::SquareTable.new)
      @interface = interface
      @surface = surface

      @mobility_system = MobilitySystem.new
      @navigation_system = NavigationSystem.new(@surface, @mobility_system)
      @reporter = Reporter.new(@navigation_system)
    end

    # Starts reading user's input using given interface
    # Finishes reading the instructions when EOF is reached
    def play
      command = interface.read_command
      while command
        interpret_command(command)
        command = interface.read_command
      end
    end
  end
end