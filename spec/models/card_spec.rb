require 'rails_helper'
require 'support/domainable_specs'

RSpec.describe Card, type: :model do
  it_behaves_like 'domainable'

  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:slug).of_type(String) }
    it { is_expected.to have_field(:num).of_type(Integer).with_default_value_of(0) }
    it { is_expected.to have_field(:published_at).of_type(Time) }
  end

  describe 'card unpublished/published' do
    let(:card) { Card.find_or_create_unpublished }
    it { expect(card).to be_unpublished }
    it { expect(card.name).to be_blank }
    it { expect(card.slug).to be_blank }

    context 'reuse unpublished card' do
      let(:card2) { Card.find_or_create_unpublished }
      it { expect(card2).to match card }
      it { expect(card2.id).to eq card.id }
    end
  end

  # describe 'validations' do
  #   # it { is_expected.to validate_presence_of(:name) }
  #   it { is_expected.to validate_presence_of(:slug) }
  #   it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:domain_id).case_insensitive }
  #   it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
  #   it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
  # end

end
