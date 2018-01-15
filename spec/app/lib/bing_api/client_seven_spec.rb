require 'rails_helper'

RSpec.describe BingApi::ClientSeven, type: :lib do
  context 'path + uri' do
    let(:base_uri) {  'https://api.cognitive.microsoft.com' }
    let(:base_path) { '/bing/v7.0/search' }

    subject { BingApi::ClientSeven }

    it 'has base_uri with correct value' do
      expect(subject.base_uri).to eq(base_uri)
    end

    it 'has base_path with correct value' do
      expect(subject.base_path).to eq(base_path)
    end
  end

  describe 'initialize' do
    let!(:company) { create(:company) }

    subject { BingApi::ClientSeven.new(company_id: company.id) }

    it 'sets @company from given args' do
      expect(subject.instance_variable_get(:@options)).to eq(company_id: company.id)
    end
  end

  describe '#search', vcr: true do
    let!(:company) { create(:company, domain: 'softserve.com') }
    let!(:bing) { BingApi::ClientSeven.new(company_id: company.id) }

    subject { bing.search }

    context 'with valid API response', vcr: true do
      it 'returns parsed response' do
        expect { subject }.not_to raise_error
        expect(subject).to be_a(Hash)
        expect(subject).not_to be_empty
        expect(subject).to have_key('webPages')
        expect(subject['webPages']).to have_key('value')
        expect(subject["webPages"]["value"]).to be_a_kind_of(Array)
      end
    end
  end

  describe '#pages_process', vcr: true do
    let!(:company) { create(:company, domain: 'softserve.com') }
    let!(:bing) { BingApi::ClientSeven.new(company_id: company.id) }

    subject { bing.pages_process }

    context 'with API data response' do
      it 'creates pages for company' do
        expect { subject }.to change { company.pages.count }.by(10)
      end
    end

    context 'with blank API data response' do
      it 'does not creates pages for company' do
        allow(bing).to receive(:search).and_return({})

        expect { subject }.to_not change(company.pages, :count)
      end

      it 'returns nil if "webPages" data is blank' do
        allow(bing).to receive(:search).and_return('webPages': nil)

        expect(subject).to eq(nil)
      end

      it 'returns nil if "webPages" "value" is blank' do
        allow(bing).to receive(:search).and_return('webPages': { 'value': nil })

        expect(subject).to eq(nil)
      end
    end
  end
end
