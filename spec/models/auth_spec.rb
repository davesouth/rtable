require 'rails_helper'

RSpec.describe Auth, type: :model do
  include_context 'test_domain'

  describe 'associations' do
    it { is_expected.to be_embedded_in(:card) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:token).of_type(String) }
    it { is_expected.to have_field(:expired_at).of_type(Time) }
  end

  describe '.create' do
    let(:card) { Fabricate :card }

    context 'when creating auth' do
      subject { card.create_auth }

      it { expect(subject.token).to match /\A[A-Za-z0-9]{16}\z/ }
      it { expect(subject.expired_at).to be > 9.minutes.from_now }
      it { expect(subject.expired_at).to be < 11.minutes.from_now }
      it { expect(subject.params).to match(
        user_id: card.id.to_s, token: /\A[A-Za-z0-9]{16}\z/) }
      it { expect(subject.validate('invalid-token')).to be false }
      it { expect(subject.validate(subject.token)).to be true }
    end
  end

end
