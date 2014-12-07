class State

  def initialize(name, initial)
    @name = name
    @initial = initial
    @transitions = Hash.new
  end

  def to_s
    puts "State #{@name} initial? #{@initial}"
  end

end