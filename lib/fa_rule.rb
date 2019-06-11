module SimpleComputers
  class FARule
    def initialize(match_state:, match_char:, next_state:)
      @match_state = match_state
      @match_char = match_char
      @next_state = next_state
    end

    def applies_to?(state, char)
      match_state == state &&
        match_char == char
    end

    def follow
      next_state
    end

    private

    attr_reader :match_state, :match_char, :next_state
  end
end
