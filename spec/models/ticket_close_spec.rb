require 'rails_helper'

RSpec.describe TicketClose, type: :model do
  describe 'schema' do
    it { is_expected.to have_field(:closed_at).of_type(Time) }
  end
end
