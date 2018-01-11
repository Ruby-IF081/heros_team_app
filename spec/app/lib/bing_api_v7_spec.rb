require 'rails_helper'

RSpec.describe BingApiV7, type: :lib do
  context 'contants' do
    let(:bing_uri) {  'https://api.cognitive.microsoft.com' }
    let(:bing_path) { '/bing/v7.0/search' }

    subject { BingApiV7 }

    it 'has BING_URI constant with correct value' do
      expect(subject::BING_URI).to eq(bing_uri)
    end

    it 'has BING_PATH constant with correct value' do
      expect(subject::BING_PATH).to eq(bing_path)
    end
  end


  describe 'initialize' do
    let!(:company) { build(:company) }

    subject { BingApiV7.new(company) }

    it 'sets @company from given args' do
      expect(subject.instance_variable_get(:@element)).to eq(company)
    end
  end

  describe '#uri' do
    let!(:company) { build(:company, domain: 'softserve.com') }

    subject { BingApiV7.new(company) }

    it 'builds correct url' do
      expect(subject.uri(company.domain).to_s).to eq("#{BingApiV7::BING_URI}#{BingApiV7::BING_PATH}?q=#{CGI.escape(company.domain || '')}")
    end
  end

  describe '#search', vcr: true do
    let!(:company) { create(:company, domain: 'softserve.com') }
    let!(:bing) { BingApiV7.new(company) }

    subject { bing.search(query: company.domain) }

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
    let!(:bing) { BingApiV7.new(company) }

    subject { bing.pages_process }

    context 'with API data response' do
      it 'creates pages for company' do
        expect { subject }.to change { company.pages.count }.by(10)
      end
    end

    context 'with blank API data response' do
      it 'does not creates pages for company' do
        allow(bing).to receive(:search).and_return({})

        expect { subject }.not_to change { company.pages.count }
      end

      it 'returns nil if "webPages" data is blank' do
        allow(bing).to receive(:search).and_return({ 'webPages' => nil })

        expect(subject).to eq(nil)
      end

      it 'returns nil if "webPages" "value" is blank' do
        allow(bing).to receive(:search).and_return({ 'webPages' => { 'value' => nil } })

        expect(subject).to eq(nil)
      end
    end
  end
end
