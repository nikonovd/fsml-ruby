require 'state'

class StateMachine


  def initialize
    @states = Hash.new
  end

  def add_state(name, initial)
    @states[name] = Array.new if @states[name].nil?
    state = State.new(name, initial)
    @states[name].push(state)
    return state
  end

  def add_transition(from_state, to_state, input, action)
    @states[from_state].each do |state|
      state.add_transition(to_state, input, action) if not state.nil?
    end
  end

  def to_s
    @states.to_s
  end

end