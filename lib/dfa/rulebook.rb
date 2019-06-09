module DFA
  class Rulebook
    def initialize(rules)
      @rules = rules
    end

    def next_state(state, char)
      match = rules.find do |rule|
        rule.applies_to?(state, char)
      end
      
      fail NoMatchingRulesError.new(state, char) if !match
      match.follow
    end

    private

    attr_reader :rules

    class NoMatchingRulesError < StandardError
      def initialize(state, char)
        msg = "No rules could be found which match state: `#{state}`, with char: `#{char}`"
        super(msg)
      end
    end
  end
end
