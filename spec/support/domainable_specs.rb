shared_examples_for 'domainable' do
  include_context 'test_domain'

  context 'schema' do
    it { is_expected.to have_field(:domain_id).of_type(Integer) }
    it { is_expected.to validate_presence_of(:domain_id) }
    it { is_expected.to validate_numericality_of(:domain_id) }
  end

  context 'model.domain' do
    let(:example) { described_class.new }
    it { expect(example.domain_id).to eq(1) }
  end

end

shared_context 'test_domain' do
  before { Domain.current = Domain.find_by_host('www.example.com') }
end
