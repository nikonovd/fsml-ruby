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

  def to_s
    @states.to_s
  end

end