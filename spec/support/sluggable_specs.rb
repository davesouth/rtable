shared_examples_for 'sluggable' do

  describe 'associations' do
    it { is_expected.to belong_to(:category).with_optional }
  end

  describe 'schema' do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:slug).of_type(String) }
    it { is_expected.to have_field(:num).of_type(Integer).with_default_value_of(0) }
    # it { is_expected.to have_field(:published_at).of_type(Time) }
    it { is_expected.to have_field(:p_at).with_alias(:published_at).of_type(Time) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).scoped_to(:domain_id).case_insensitive }
    it { is_expected.to validate_format_of(:slug).to_allow('valid-slug-1') }
    it { is_expected.to validate_format_of(:slug).not_to_allow('Invalid slug') }
  end

  describe 'indexes' do
    it { is_expected.to have_index_for(domain_id: 1, slug: 1) }
    it { is_expected.to have_index_for(domain_id: 1, published_at: 1) }
  end



  describe 'draft model' do
    let(:model) { described_class.find_or_create_draft }

    context 'when draft model' do
      it { expect(model).to be_draft }
      it { expect(model).to_not be_published }
      it { expect(model.name).to be_blank }
      it { expect(model.slug).to match /tmp-\d+/ }
    end

    context 'when reusing draft model' do
      let(:model2) { described_class.find_or_create_draft }
      it { expect(model2).to match model }
      it { expect(model2.id).to eq model.id }
    end

    context 'when publishing incomplete draft model' do
      subject { model.update(published_at: Time.now.utc) ; model }
      it { is_expected.to_not be_valid }
      it { expect(subject.errors[:name]).to match ["can't be blank"] }
      it { expect(subject.errors[:category]).to match ["can't be blank"] }
    end

    context 'when publishing complete model' do
      let(:published) { Fabricate described_class.to_s.downcase }
      it { expect(published).to be_valid }
    end

  end

end
