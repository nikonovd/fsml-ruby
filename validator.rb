require 'exceptions'
require 'state'

class Validator

  include Exceptions

  def initialize(state_machine)
    @state_machine = state_machine
  end

  def validate
    check_single_initial()
    check_distinct_ids()
    check_determinism()
    check_reachability()
    check_resolvability()
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
    initial_state = @state_machine.get_initial
    all_reachable_states = get_all_reachable_states(initial_state)
    available_states = @state_machine.to_state_array
    all_reachable_states.sort! { |a,b| a.name <=> b.name }
    available_states.sort! { |a,b| a.name <=> b.name }

    raise ReachableException if all_reachable_states != available_states
  end

  def check_resolvability
    transitions = all_transitions()
    transitions.each do |transition|
      raise ResolvableException unless not @state_machine.get_state(transition.to).nil?
    end
  end

  def check_determinism
    states = @state_machine.to_state_array
    states.each do |state|
      transitions = state.transitions
      # ensure there is only one transition per input for each state
      transitions.each { |_, transition_array| raise DeterministicException if transition_array.length > 1 }
    end
  end

  private

  def all_transitions
    transitions = Array.new
    @state_machine.to_state_array.each { |state| transitions.push(state.transitions.values) }
    return transitions.flatten
  end

  def get_all_reachable_states(initial_state)
    all_reachable = Array.new
    visit_states(initial_state, all_reachable)

    return all_reachable
  end

  def visit_states(current_state, visited_states)
    current_reachable = current_state.get_reachable_states(@state_machine)
    current_reachable.each do |state|
      if not visited_states.include? state
        visited_states.push state
        visit_states(state, visited_states)
      end
    end
  end

end