require 'state_machine'
require 'transition'
require 'erb'

class CodeGenerator

  def initialize(state_machine)
    @state_machine = state_machine
    @steps = state_machine.states.keys
    @initial_state = state_machine.get_initial
    @actions = all_actions()
    @handler_class_name = "DefaultHandler"
    @stepper_class_name = "DefaultStepper"
    @transitions = all_transitions()
  end

  def generate
    handler_file = File.read("handler.rb.template")
    stepper_file = File.read("stepper.rb.template")

    handler_renderer = ERB.new(handler_file)
    stepper_renderer = ERB.new(stepper_file)

    File.open("#{@handler_class_name}.rb", 'w+') do |f|
      f.write(handler_renderer.result(binding))
      f.close
    end
    File.open("#{@stepper_class_name}.rb", 'w+') do |f|
      f.write(stepper_renderer.result(binding))
      f.close
    end
  end

  private

  def all_actions
    actions = Array.new
    all_transitions().each do |transition|
      actions.push(transition.action)
    end
    return actions
  end

  def all_transitions
    transitions = Array.new
    @state_machine.to_state_array.each { |state| transitions.push(state.transitions.values) }
    return transitions.flatten
  end


end