shared_examples_for 'domainable' do

  include_context 'current_domain'
  it { is_expected.to belong_to(:domain) }

end

shared_context 'current_domain' do
  before do
    # Create test domain for www.example.com
    Domain.create slug: 'www', name: 'Example'

    # Set current domain to test domain
    Domain.current = Domain.find_by slug: 'www'
  end
end
