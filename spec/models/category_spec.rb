require 'rails_helper'

RSpec.describe Category, type: :model do
  it_behaves_like 'domainable'

  describe 'associations' do
    it { is_expected.to have_many(:cards) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:slug).of_type(String) }
    it { is_expected.to have_field(:kind).of_type(String) }
    it { is_expected.to have_field(:name).of_type(String) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:domain_id).case_insensitive }
    it { is_expected.to validate_exclusion_of(:slug).to_not_allow('tmp') }
    it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_inclusion_of(:kind).to_allow('tickets', 'cards') }
  end

end
