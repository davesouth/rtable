require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:tickets) }
    it { is_expected.to have_many(:cards) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:slug).of_type(String) }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(slug: 1) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
    it { is_expected.to validate_exclusion_of(:slug).to_not_allow('warden') }
  end

end
