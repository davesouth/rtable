require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'schema' do
    it { is_expected.to have_field(:body).of_type(String) }
  end
end
