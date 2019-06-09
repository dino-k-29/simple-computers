require 'fa_rule'
require 'dfa/rulebook'
require 'dfa'

RSpec.describe DFA::Machine do
  let(:dfa) do
    described_class.new start_state: 1, accept_states: [3], \
      rulebook: rulebook
  end

  describe "#accepting?" do
    before { dfa.read_string(string) }
    subject { dfa.accepting? }

    context "accepting any string with the sequence `ab`" do
      let(:rulebook) do
        DFA::Rulebook.new \
          [
            FARule.new(match_state: 1, match_char: 'a', next_state: 2),
            FARule.new(match_state: 1, match_char: 'b', next_state: 1),
            FARule.new(match_state: 2, match_char: 'a', next_state: 2),
            FARule.new(match_state: 2, match_char: 'b', next_state: 3),
            FARule.new(match_state: 3, match_char: 'a', next_state: 3),
            FARule.new(match_state: 3, match_char: 'b', next_state: 3)
          ]
      end
      
      context "rejecting `a`" do
        let(:string) { 'a' }
        it { expect(subject).to be false }
      end

      context "rejecting `baa`" do
        let(:string) { 'baa' }
        it { expect(subject).to be false }
      end

      context "accepting `baba`" do
        let(:string) { 'baba' }
        it { expect(subject).to be true }
      end
    end
  end
end
