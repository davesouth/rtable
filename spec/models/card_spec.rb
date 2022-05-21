require 'rails_helper'

RSpec.describe Card, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'
  it_behaves_like 'userable'
  it_behaves_like 'authorable'

  describe 'associations' do
    it { is_expected.to have_many(:cards).with_foreign_key(:author_id) }
    it { is_expected.to have_many(:tickets).with_foreign_key(:author_id) }
  end

end
