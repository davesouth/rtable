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

  describe 'validations' do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:domain_id).case_insensitive }
    it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category).with_optional }
  end

  describe 'draft card' do
    let(:card) { Card.find_or_create_draft }

    context 'when draft card' do
      it { expect(card).to be_draft }
      it { expect(card).to_not be_published }
      it { expect(card.name).to be_blank }
      it { expect(card.slug).to match /tmp-\d+/ }
    end

    context 'when reusing draft card' do
      let(:card2) { Card.find_or_create_draft }
      it { expect(card2).to match card }
      it { expect(card2.id).to eq card.id }
    end

    context 'when publishing incomplete draft card' do
      subject { card.update(published_at: Time.now.utc) ; card }
      it { is_expected.to_not be_valid }
      it { expect(subject.errors[:name]).to match ["can't be blank"] }
      it { expect(subject.errors[:category]).to match ["can't be blank"] }
    end

    context 'when publishing complete card' do
      let(:published) { Fabricate :card }
      it { expect(published).to be_valid }
    end

  end

end
