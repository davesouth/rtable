require 'rails_helper'

RSpec.describe User, type: :model do
  include_context 'test_domain'

  describe 'associations' do
    it { is_expected.to be_embedded_in(:card) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:role).of_type(String) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_inclusion_of(:role).
      to_allow('owner', 'staff', 'blocked') }
  end

end
