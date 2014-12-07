require 'transition'

class State

  attr_reader :name

  private :initialize_transitions, :sanitize_to_state

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
    @transitions[input].push(Transition.new(self.name, sanitize_to_state(to_state), input, action))
  end

  def sanitize_to_state(to_state)
    to_state = self.name if to_state.nil? || to_state.empty?
    return to_state
  end

  def initialize_transitions(input)
    @transitions[input] = Array.new if @transitions[input].nil?
  end

end