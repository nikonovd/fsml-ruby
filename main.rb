$:.unshift File.dirname(__FILE__)

require 'FSMLParser'
require 'state_machine'
require 'validator'
require 'exceptions'
require 'visualizer'
require 'simulator'
require 'code_generator'

if ARGV.length == 0
  puts "no input file passed as argument."
  return
end
input = File.read(ARGV[0]);

begin
# parsing
  parser = FSML::Parser.new(input)
  machine = parser.to_ast()
# validation
  validator = Validator.new(machine)
  validator.validate()
# simluate with sample input
  sample_input = ["ticket", "pass", "ticket", "pass", "ticket", "ticket", "pass", "pass", "ticket", "pass", "mute", "release", "ticket", "pass"]
  simulator = Simulator.new(machine)
  simulator.simulate(sample_input)
# generate ruby code for stepper and handler
  generator = CodeGenerator.new(machine)
  generator.generate
# print graph
  visualizer = Visualizer.new(machine, ARGV[0])
  visualizer.visualize()
  visualizer.print_graph()
rescue Exceptions::FSMLException => e
  puts "ERROR: Exception of type #{e.class.name} raised during the process!"
end
