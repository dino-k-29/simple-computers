require 'fa_rule'

RSpec.describe FARule do
  describe '#applies_to?' do
    let(:fa_rule) do
      described_class.new(match_state: 1,
                          match_char: 'b',
                          next_state: 3)
    end

    subject { fa_rule.applies_to?(state, char) }

    context "when neither state or char match the rule" do
      let(:state) { 2 }
      let(:char) { 'a' }

      it { expect(subject).to be false }
    end

    context "when state matches but char doesn't" do
      let(:state) { 1 }
      let(:char) { 'a' }

      it { expect(subject).to be false }
    end

    context "when char matches but state doesn't" do
      let(:state) { 2 }
      let(:char) { 'b' }

      it { expect(subject).to be false }
    end

    context "when both state and char match" do
      let(:state) { 1 }
      let(:char) { 'b' }

      it { expect(subject).to be true }
    end
  end
end
