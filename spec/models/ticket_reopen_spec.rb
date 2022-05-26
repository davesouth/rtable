require 'rails_helper'

RSpec.describe TicketReopen, type: :model do
  describe 'schema' do
    it { is_expected.to have_field(:reopened_at).of_type(Time) }
  end
end
