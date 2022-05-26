require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'
  it_behaves_like 'authorable'

  describe 'schema' do
    it { is_expected.to have_field(:closed_at).of_type(Time) }
  end

  describe 'closure' do
    let(:ticket) { Fabricate :ticket }

    context 'when open' do
      it { expect(ticket.state).to eq 'open' }
      it { expect(ticket.open?).to be true }
      it { expect(ticket.closed?).to be false }
    end

    context 'when closed' do
      subject { ticket.update(closed_at: Time.now.utc) ; ticket }
      it { expect(subject.state).to eq 'closed' }
      it { expect(subject.open?).to be false }
      it { expect(subject.closed?).to be true }
    end

  end

end
