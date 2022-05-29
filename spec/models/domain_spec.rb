require 'rails_helper'

RSpec.describe Domain, type: :model do

  describe 'Domain.domains' do
    it { expect(Domain.domains).to match({ 'www.example.com': { id: 1, name: 'Test' } }) }
  end

  describe 'Domain.find_by_host' do
    subject { Domain.find_by_host('www.example.com') }
    it { expect(subject).to be_an_instance_of Domain }
    it { expect(subject.id).to eq 1 }
    it { expect(subject.name).to eq 'Test' }
  end

  describe 'Domain.find_by_host_id' do
    subject { Domain.find_by_host_id(1) }
    it { expect(subject).to be_an_instance_of Domain }
    it { expect(subject.id).to eq 1 }
    it { expect(subject.name).to eq 'Test' }
  end

end
