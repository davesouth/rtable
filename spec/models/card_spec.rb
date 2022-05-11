require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:account) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:slug).of_type(String) }
    it { is_expected.to have_field(:kind).of_type(String) }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(account_id: 1, slug: 1) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    # it { is_expected.to validate_uniqueness_of(:slug).scoped_to([:account_id]).case_insensitive }
    # it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    # it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
    # it { is_expected.to validate_presence_of(:kind) }
    # it { is_expected.to validate_inclusion_of(:kind).to_allow('tickets', 'cards') }
  end
end
