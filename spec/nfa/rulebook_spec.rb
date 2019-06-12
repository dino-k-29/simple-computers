require 'fa_rule'
require 'nfa/rulebook'

module SimpleComputers
  RSpec.describe NFA::Rulebook do
    describe "#next_state" do
      let(:rule_1) { instance_double(FARule) }
      let(:rule_2) { instance_double(FARule) }

      let(:rulebook) do
        described_class.new([rule_1, rule_2])
      end

      let(:current_states) { [1, 2] }
      let(:char) { 'x' }

      subject { rulebook.next_states(current_states, char) }

      before do
        allow(rule_1).to receive(:applies_to?)
                           .with(current_states[0], char)
                           .and_return(match)

        allow(rule_2).to receive(:applies_to?)
                           .with(current_states[1], char)
                           .and_return(match)

        allow(rule_1).to receive(:applies_to?)
                           .with(current_states[1], char)
                           .and_return(false)

        allow(rule_2).to receive(:applies_to?)
                           .with(current_states[0], char)
                           .and_return(false)
      end

      context "without any matching rules" do
        let(:match) { false }

        it "returns an empty set" do
          expect(subject).to eq(Set[])
        end
      end

      context "with some matching rules" do
        let(:match) { true }

        before do
          allow(rule_1).to receive(:follow).and_return(3)
          allow(rule_2).to receive(:follow).and_return(5)
        end

        it "follows the matching rules" do
          expect(subject).to eq(Set[3, 5])
        end
      end
    end

    describe "#free_moves" do
      let(:rule) { instance_double(FARule) }
      let(:rulebook) { described_class.new([rule]) }

      subject { rulebook.free_moves(Set[1]) }

      before do
        allow(rule).to receive(:applies_to?)
                         .with(1, nil)
                         .and_return(match)

        allow(rule).to receive(:applies_to?)
                         .with(3, nil)
                         .and_return(false)
      end

      context "without any free move rules" do
        let(:match) { false }

        it "returns the input states" do
          expect(subject).to eq(Set[1])
        end
      end

      context "with a free move rule" do
        let(:match) { true }

        before do
          allow(rule).to receive(:follow).and_return(3)
        end

        it "includes the next state from the free rule" do
          expect(subject).to eq(Set[1, 3])
        end
      end
    end
  end
end
