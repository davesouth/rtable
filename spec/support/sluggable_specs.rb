shared_examples_for 'sluggable' do

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:slug).of_type(String) }
    it { is_expected.to have_field(:num).of_type(Integer).with_default_value_of(0) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:domain_id).case_insensitive }
    it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(domain_id: 1, slug: 1) }
  end

end
