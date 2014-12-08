require 'exceptions'
require 'state'

class Validator

  include Exceptions

  def initialize(state_machine)
    @state_machine = state_machine
  end

  def validate
    check_single_initial
    check_distinct_ids
    check_determinism
    check_reachability
    check_resolvability
  end

  def check_single_initial
    states = @state_machine.to_state_array
    raise SingleInitialStateException if states.keep_if { |state| state.initial? }.length != 1
  end

  def check_distinct_ids
    @state_machine.states.each do |_, states|
      raise DistinctIdsException if states.length > 1
    end
  end

  def check_reachability

  end

  def check_resolvability

  end

  def check_determinism

  end

end