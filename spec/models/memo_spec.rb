require 'rails_helper'

RSpec.describe Memo, type: :model do
  it_behaves_like 'authorable'

  describe 'associations' do
    it { is_expected.to be_embedded_in(:ticket) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:published_at).of_type(Time) }
  end

end
