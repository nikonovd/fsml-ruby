$:.unshift File.dirname(__FILE__)

require 'FSMLParser'
require 'state_machine'
require 'validator'
require 'exceptions'
require 'visualizer'
require 'simulator'

if ARGV.length == 0
  puts "No input file passed as argument."
else
  input = File.read(ARGV[0]);

  parser = FSML::Parser.new(input);
  machine = parser.to_ast()

  validator = Validator.new(machine)

  begin
    # validation
    validator.validate()

    # simluate with sample input
    sample_input = ["ticket", "pass", "ticket", "pass", "ticket", "ticket", "pass", "pass", "ticket", "pass", "mute", "release", "ticket", "pass"]
    simulator = Simulator.new(machine)
    simulator.simulate(sample_input)

    # todo: generate ruby code for stepper and handler

    # print graph
    visualizer = Visualizer.new(machine, ARGV[0])
    visualizer.visualize()
    visualizer.print_graph()
  rescue Exceptions::FSMLException => e
    raise e
  end
end
