require 'transition'

class State

  attr_reader :name

  def initialize(name, initial)
    @name = name
    @initial = initial
    @transitions = Hash.new
  end

  def add_transition(to_state, input, action)
    @transitions[input] = Array.new if @transitions[input].nil?
    to_state = self.name if to_state.nil? || to_state.empty?
    @transitions[input].push(Transition.new(self.name, to_state, input, action))
  end

  def initial?
    @initial == true
  end

end