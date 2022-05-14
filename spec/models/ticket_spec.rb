require 'rails_helper'
require 'support/domainable_specs'
require 'support/sluggable_specs'

RSpec.describe Ticket, type: :model do
  it_behaves_like 'domainable'
  it_behaves_like 'sluggable'
end
