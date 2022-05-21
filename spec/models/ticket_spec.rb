require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'
  it_behaves_like 'authorable'
end
