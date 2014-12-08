require 'transition'

class State

  attr_reader :name, :transitions

  def initialize(name, initial)
    @name = name
    @initial = initial
    @transitions = Hash.new
  end

  def initial?
    @initial == true
  end

  def add_transition(to_state, input, action)
    initialize_transitions(input)
    add_transition_for_input(action, input, to_state)
  end

  def add_transition_for_input(action, input, to_state)
    @transitions[input].push(Transition.new(self.name, sanitize_to_state(to_state), input, action))
  end

  def sanitize_to_state(to_state)
    to_state = (to_state.nil? or to_state.empty?) ? self.name : to_state;
    return to_state
  end

  def initialize_transitions(input)
    @transitions[input] = Array.new if @transitions[input].nil?
  end

  private :initialize_transitions, :add_transition_for_input, :sanitize_to_state

end