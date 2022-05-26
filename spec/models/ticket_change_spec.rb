require 'rails_helper'

RSpec.describe TicketChange, type: :model do
  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:old_name).of_type(String) }
  end
end
