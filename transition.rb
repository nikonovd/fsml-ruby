class Transition

  attr_reader :to, :input, :action

  def initialize(from_state, to_state, input, action)
    @from = from_state
    @to = to_state
    @input = input
    @action = action
  end

end