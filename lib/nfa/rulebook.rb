module SimpleComputers
  module NFA
    class Rulebook
      def initialize(rules)
        @rules = rules
      end

      def next_states(current_states, char)
        current_states.flat_map do |state|
          follow_rules(state, char)
        end.to_set
      end

      private

      attr_reader :rules

      def follow_rules(state, char)
        matching_rules(state, char).map(&:follow)
      end

      def matching_rules(state, char)
        rules.select do |rule|
          rule.applies_to?(state, char)
        end
      end
    end
  end
end
