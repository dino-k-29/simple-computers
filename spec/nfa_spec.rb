require 'set'
require 'fa_rule'
require 'nfa/rulebook'
require 'nfa'

module SimpleComputers
  RSpec.describe NFA::Machine do
    let(:nfa) do
      described_class.new current_states: Set[1], \
                          accept_states: Set[4],
                          rulebook: rulebook
    end

    describe "#accepting?" do
      before { nfa.read_string(string) }
      subject { nfa.accepting? }

      context "accepting any string with `b` as the third from last character" do
        let(:rulebook) do
          NFA::Rulebook.new \
            [ FARule.new(match_state: 1, match_char: 'a', next_state: 1),
              FARule.new(match_state: 1, match_char: 'b', next_state: 1),
              FARule.new(match_state: 1, match_char: 'b', next_state: 2),
              FARule.new(match_state: 2, match_char: 'a', next_state: 3),
              FARule.new(match_state: 2, match_char: 'b', next_state: 3),
              FARule.new(match_state: 3, match_char: 'a', next_state: 4),
              FARule.new(match_state: 3, match_char: 'b', next_state: 4) ]
        end

        context "rejecting `abb`" do
          let(:string) { 'abb' }
          it { expect(subject).to be false }
        end

        context "rejecting `bbabb`" do
          let(:string) { 'bbabb' }
          it { expect(subject).to be false }
        end

        context "accepting `baa`" do
          let(:string) { 'baa' }
          it { expect(subject).to be true }
        end

        context "accepting `bbbb`" do
          let(:string) { 'bbbb' }
          it { expect(subject).to be true }
        end
      end
    end
  end
end
