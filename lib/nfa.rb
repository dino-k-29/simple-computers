module SimpleComputers
  module NFA
    class Machine
      def initialize(current_states:, accept_states:, rulebook:)
        @current_states = current_states
        @accept_states = accept_states
        @rulebook = rulebook
      end

      def read_string(string)
        string.each_char { |char| read_character(char) }
      end

      def accepting?
        (accept_states & current_states).any?
      end

      private

      def read_character(char)
        self.current_states =
          rulebook.next_states(current_states, char)
      end

      attr_writer :current_states
      attr_reader :accept_states, :rulebook

      def current_states
        rulebook.free_moves(@current_states)
      end
    end
  end
end
