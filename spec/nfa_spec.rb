require 'set'
require 'fa_rule'
require 'nfa/rulebook'
require 'nfa'

module SimpleComputers
  RSpec.describe NFA::Machine do
    let(:nfa) do
      described_class.new current_states: current_states, \
                          accept_states: accept_states,
                          rulebook: rulebook
    end

    describe "#accepting?" do
      before { nfa.read_string(string) }
      subject { nfa.accepting? }

      context "accepting any string with `b` as the third from last character" do
        let(:current_states) { Set[1] }
        let(:accept_states) { Set[4] }

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

      context "accepting strings whose length is a multiple of 2 or 3" do
        let(:current_states) { Set[1] }
        let(:accept_states) { Set[2, 4] }

        let(:rulebook) do
          NFA::Rulebook.new \
            [ FARule.new(match_state: 1, match_char: nil, next_state: 2),
              FARule.new(match_state: 1, match_char: nil, next_state: 4),
              FARule.new(match_state: 2, match_char: 'a', next_state: 3),
              FARule.new(match_state: 3, match_char: 'a', next_state: 2),
              FARule.new(match_state: 4, match_char: 'a', next_state: 5),
              FARule.new(match_state: 5, match_char: 'a', next_state: 6),
              FARule.new(match_state: 6, match_char: 'a', next_state: 4) ]
        end

        context "rejecting `aaaaa`" do
          let(:string) { 'aaaaa' }
          it { expect(subject).to be false }
        end

        context "accpeting `aa`" do
          let(:string) { 'aaa' }
          it { expect(subject).to be true }
        end

        context "accepting `aaa`" do
          let(:string) { 'aaa' }
          it { expect(subject).to be true }
        end

        context "accepting `aaaaaa`" do
          let(:string) { 'aaaaaa' }
          it { expect(subject).to be true }
        end
      end
    end
  end
end
