require 'graphviz'

class Visualizer

  attr_reader :graph

  def initialize(state_machine, graph_name)
    @state_machine = state_machine
    @graph_name = graph_name
    @nodes = Hash.new
  end

  def visualize
    @graph = GraphViz.new(@graph_name, :strict => false, :rankdir => 'LR', :nodesep => 0.5)
    append_nodes()
  end

  def print_graph
    @graph.output(:png => "#{@graph_name}.png")
  end

  def append_nodes
    @state_machine.states.each do |state_array|
      state = @state_machine.states[state_array.first].first
      state.initial? ? @nodes[state.name] = @graph.add_node(state.name, :shape => 'ellipse', :style => 'filled') : @nodes[state.name] = @graph.add_node(state.name, :shape => 'ellipse')
      append_transitions(state)
    end
  end

  def append_transitions(state)
    state.transitions.each do |key, transition_array|
      transition_array.each do |transition|
        create_transition(state, transition)
      end
    end
  end

  def create_transition(state, transition)
    from = state.name
    to = (transition.to.nil? or transition.to.empty?) ? from : transition.to
    label = transition.input + ((transition.action.nil? or transition.action.empty?) ? '' : '/' + transition.action)
    @graph.add_edge(from, to, :label => label)
  end

  private :append_nodes, :append_transitions, :create_transition
end
