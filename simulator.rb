require 'state_machine'
require 'state'
require 'transition'
require 'rinda/rinda'
require 'exceptions'

class Simulator

  include Exceptions

  def initialize(state_machine)
    @state_machine = state_machine
    @initial = state_machine.get_initial()
  end

  def simulate(input)
    current_state = @initial
    output = Array.new
    input.each do |current_input|
      raise IllegalInputException if current_state.transitions[current_input].nil?
      transition = current_state.transitions[current_input].first
      next_state_name = transition.to
      # use Rinda::Tuple because ruby does not have built in support for tuples like e.g. python
      output.push(Rinda::Tuple.new([transition.action, next_state_name]))
      current_state = @state_machine.get_state(next_state_name)
    end
  end

end