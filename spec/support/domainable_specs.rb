shared_examples_for 'domainable' do

  include_context 'current_domain'

  it { is_expected.to belong_to(:domain) }
  it { is_expected.to have_index_for(domain_id: 1, slug: 1) }

  # it { is_expected.to validate_presence_of(:domain_id) }

    # it { is_expected.to have_field(:domain_id).of_type(Integer) }
    # it { is_expected.to validate_numericality_of(:domain_id) }

end

shared_context 'current_domain' do
  before do
    # Create test domain for www.example.com
    Domain.create slug: 'www', name: 'Example'

    # Set current domain to test domain
    Domain.current = Domain.find_by slug: 'www'
  end
end
