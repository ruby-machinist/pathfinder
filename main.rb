require 'pathfinder'

if from_file = ARGV.detect {|arg| /\A--from-file=/ =~ arg }
  ARGV.delete(from_file)
  filename = from_file.split(/=/, 2)[1]
  interface = Pathfinder::Interfaces::FileInput.new(filename)
else
  interface = Pathfinder::Interfaces::StandardInput.new
end

robot = Pathfinder::Robot.new(interface)
robot.play


