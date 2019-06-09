class DFA::Machine
  def initialize(start_state:, accept_states:, rulebook:)
    @current_state = start_state
    @accept_states = accept_states
    @rulebook = rulebook
  end

  def read_string(string)
    string.each_char { |char| read_character(char) }
  end

  def accepting?
    accept_states.include? current_state
  end

  private

  def read_character(char)
    self.current_state = rulebook.next_state(current_state, char)
  end

  attr_accessor :current_state
  attr_reader :accept_states, :rulebook
end
