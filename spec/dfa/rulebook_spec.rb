require 'fa_rule'
require 'dfa/rulebook'

module SimpleComputers
  RSpec.describe DFA::Rulebook do
    describe "#next_state" do
      let(:rule) { instance_double(FARule) }
      let(:rulebook) { described_class.new([rule]) }
      let(:args) { [1, 'x'] }

      subject { rulebook.next_state(*args) }

      before do
        allow(rule).to receive(:applies_to?)
                         .with(*args)
                         .and_return(match)
      end

      context "without a matching rule" do
        let(:match) { false }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::NoMatchingRulesError)
        end
      end

      context "with a matching rule" do
        let(:match) { true }

        before do
          allow(rule).to receive(:follow)
                           .and_return(2)
        end

        it "follows the matching rule" do
          expect(subject).to eq(2)
        end
      end
    end
  end
end
