require 'rails_helper'

RSpec.describe Memo, type: :model do
  it_behaves_like 'authorable'

  describe 'associations' do
    it { is_expected.to be_embedded_in(:ticket) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:body).of_type(String) }
  end

end
