shared_examples_for 'userable' do

  describe 'associations' do
    it { is_expected.to embed_one :auth }
    it { is_expected.to embed_one :user }
  end

  describe 'schema' do
    it { is_expected.to have_field(:email).of_type(String) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:domain_id) }
    it { is_expected.to validate_format_of(:email).to_allow('john@example.com') }
    it { is_expected.to validate_format_of(:email).not_to_allow('john2example.com') }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(domain_id: 1, email: 1) }
  end

  describe 'role method' do
    let(:card) { Fabricate :card }
    it { expect(card.role).to eq 'guest' }
    it { expect(card).to_not have_user }

    context 'when user.role set' do
      before { card.create_user role: 'owner' }
      it { expect(card.role).to eq 'owner' }
      it { expect(card.user.role).to eq 'owner' }
      it { expect(card).to have_user }
    end
  end

end
