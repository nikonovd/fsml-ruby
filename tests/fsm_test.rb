binpath = File.dirname(__FILE__)
$:.unshift File.expand_path(File.join(binpath, ".."))

require 'test/unit'
require 'FSMLParser'
require 'state_machine'
require 'validator'
require 'exceptions'

class FSMTest < Test::Unit::TestCase

  include Exceptions

  def setup
    @ids_not_ok = parse_fsm("idsNotOk.fsml")
    @initial_not_ok = parse_fsm("initialNotOk.fsml")
    @reachability_not_ok = parse_fsm("reachabilityNotOk.fsml")
    @resolution_not_ok = parse_fsm("resolutionNotOk.fsml")
  end

  def test_ids_not_ok
    validator = Validator.new(@ids_not_ok)
    assert_raise(DistinctIdsException) { validator.validate() }
  end

  def test_initial_not_ok
    validator = Validator.new(@initial_not_ok)
    assert_raise(SingleInitialStateException) { validator.validate() }
  end

  def test_reachability_not_ok
    validator = Validator.new(@reachability_not_ok)
    assert_raise(ReachableException) { validator.validate() }
  end

  def test_resolution_not_ok
    validator = Validator.new(@resolution_not_ok)
    assert_raise(ResolvableException) { validator.validate() }
  end


  private

  def parse_fsm(file_name)
    text = File.read(file_name)
    parser = FSML::Parser.new(text)
    machine = parser.to_ast()

    return machine
  end
end