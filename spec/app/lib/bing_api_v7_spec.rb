require 'rails_helper'

RSpec.describe BingApiV7 do
  describe '#search', vcr: true do
    context 'with valid response data' do
      let!(:company) { Company.create(domain: 'softserve') }
      let!(:bing) { BingApiV7.new(company) }
      subject { bing.search }

      it 'returns json parsed data' do
        expect(subject).to be_a(Hash)
        expect(subject).not_to be_empty
        expect(subject).to have_key('webPages')
        expect(subject['webPages']).to have_key('value')
        expect(subject["webPages"]["value"]).to be_a_kind_of(Array)
      end
    end
  end

  describe '#pages_process', vcr: true do
    context 'pages exist' do
      let!(:company) { Company.create(domain: 'softserve') }
      let!(:bing) { BingApiV7.new(company) }
      let!(:pages) { bing.search["webPages"]["value"] }
      it 'must have something' do
        expect(pages).to all(have_key("name"))
        expect(pages).to all(have_key("displayUrl"))
      end
    end

    context 'response not valid', vcr: false do
      let(:bing) { BingApiV7.new(Company.create(domain: 'softserve')) }

      it 'must have something exact we need' do
        allow_any_instance_of(BingApiV7).to receive(:search).and_return({})
        expect { bing.pages_process }.not_to raise_error
      end
    end
  end
end
