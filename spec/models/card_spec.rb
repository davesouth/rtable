require 'rails_helper'
require 'support/domainable_specs'
require 'support/sluggable_specs'

RSpec.describe Card, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'

  describe 'associations' do
    it { is_expected.to embed_one :auth }
  end

  describe 'schema' do
    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:role).of_type(String).with_default_value_of('guest') }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:domain_id) }
    it { is_expected.to validate_format_of(:email).to_allow('john@example.com') }
    it { is_expected.to validate_format_of(:email).not_to_allow('john2example.com') }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_inclusion_of(:role).to_allow('owner', 'staff', 'guest', 'blocked') }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(domain_id: 1, email: 1) }
  end

end
