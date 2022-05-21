require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'

  describe 'associations' do
    it { is_expected.to belong_to(:author).with_optional.as_inverse_of(:tickets) }
  end

end
