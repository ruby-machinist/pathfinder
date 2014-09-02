# Toy Robot Simulator
It's a ruby application which simulates functionality of a simple robot.


## Description
* The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.
* There are no other obstructions on the table surface.
* The robot is free to roam around the surface of the table, but it is prevented from falling to destruction. 
* Any movement that would result in the robot falling from the table is prevented, and further valid movement
commands are still be allowed.

### Development
This is OO version of the robot. It consists of:
```
         ______
        |::::::| Interface modules responsible for reading user's input,
        `------
           |
           |
           |                     .-' \
           |                  .-'     \
        .-------------------'       .-
        | [A -> B]          |    .-`  Interpreter module - it translates user's input into
        |    |              |-.-'     robot's methods
        |    V              |
        | [X10Y01FN]        |         Navigation module - it holds current placement, updates
        |    |              |         target position and direction
        |    V              |
        | [.''...]-----     |         Surface analysis module - it makes a decision whether
      .-`--------------`-.--'         robot should move or not
      |             .-----`o------.
    .-|-.         .-|-.         .-|-.
   |  o  |       |  o  |       |  o  |   And mobility module - it makes the actual move
    `._.'         '._.'         `._.'
```


## Installation

    $ git clone git://github.com/ruby-machinist/pathfinder.git
    $ cd pathfinder
    $ gem install bundler
    $ bundle install

## How to start the game?

Simply run ```ruby main.rb``` in the main folder of the application. It will use default configuration where standard
input is used for the communication.

### Alternative input

You can also use file input to send instructions to the robot: ```ruby main.rb --from-file=/path/to/your/file.txt ```
File input - beside rendering output forced by the REPORT command - will print each line stored in the file to the
standard output.

### Test data

There's a file with test data provided with this application. Run ```ruby main.rb --from-file=/path/to/your/file.txt ```
if you want to try it.

## How to play?
Robot reads in commands of the following form:
* PLACE X,Y,F
* MOVE
* LEFT
* RIGHT
* REPORT

### Description

* PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
* The origin (0,0) can be considered to be the SOUTH WEST most corner.
* The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued,
  in any order, including another PLACE command. The application discards all commands in the sequence until a valid
  PLACE command has been executed.
* MOVE will move the toy robot one unit forward in the direction it is currently facing.
* LEFT and RIGHT rotates the robot 90 degrees in the specified direction without changing the position of the robot.
* REPORT will announce the X,Y and F of the robot.
* A robot that is not on the table ignores the MOVE, LEFT, RIGHT and REPORT commands.