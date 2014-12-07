require 'state'

class StateMachine

  def initialize
    @states = Hash.new
  end

  def add_state(name, initial)
    @states[name] = Array.new if @states[name].nil?
    state = State.new(name, initial)
    @states[name] << state
  end

  def to_s
    @states.to_s
  end

end