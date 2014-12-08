require 'state'

class StateMachine

  attr_reader :states

  def initialize
    @states = Hash.new
  end

  def add_state(name, initial)
    @states[name] = Array.new if @states[name].nil?
    state = State.new(name, initial)
    @states[name].push(state)
    return state
  end

  def get_state(name)
    return @states[name].first
  end

  def to_state_array
    # call flatten operation 2 times means: first flat the hash to an array, afterwards flat the inner arrays
    return @states.flatten.flatten.keep_if { |state| state.instance_of? State }
  end

end