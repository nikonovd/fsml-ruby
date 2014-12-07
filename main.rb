$:.unshift File.dirname(__FILE__)

require 'FSMLParser'
require 'state_machine'

if ARGV.length == 0
  puts "No input file passed as argument."
else
  input = File.read(ARGV[0]);

  parser = FSML::Parser.new(input);
  puts parser.ast()
end