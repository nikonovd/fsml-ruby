$:.unshift File.dirname(__FILE__)

require 'FSMLParser'
require 'state_machine'
require 'validator'
require 'exceptions'
require 'visualizer'

if ARGV.length == 0
  puts "No input file passed as argument."
else
  input = File.read(ARGV[0]);

  parser = FSML::Parser.new(input);
  machine = parser.to_ast()

  validator = Validator.new(machine)

  begin
    validator.validate
  rescue Exceptions::ValidatorException => e
    raise e
  end

  visualizer = Visualizer.new(machine, ARGV[0])
  visualizer.visualize
  visualizer.print_graph
end
