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

  describe '#pages_process' do
    context 'cr pages for company' do
      let!(:user) { FactoryBot.create(:user, email: 'sale@sale.com',
                                             password: '1234qwer',
                                             role: 'sale') } 
      let!(:company) { FactoryBot.create(:company, name:  'Example Company',
                                                   domain: 'example.org',
                                                   user: user) }
      it 'company.pages creates' do
        expect(company.pages.create(page_type: Page::BING_TYPE,
                                    title: 'softserve',
                                    source_url: 'softserve.com',
                                    status: Page::PENDING_STATUS)).to be_valid
      end
    end

    context '#pages_process', vcr: true do
      let!(:company) { Company.create(domain: 'softserve') }
      let!(:bing) { BingApiV7.new(company) }
      let!(:pages) { bing.search["webPages"]["value"] }

      it 'should not to get error if search method return empty response' do
        allow(bing).to receive(:search).and_return({})
        expect { bing.pages_process }.not_to raise_error
      end

      it 'should have min 2 main values for our pages' do
        expect(pages).to all(have_key("name"))
        expect(pages).to all(have_key("displayUrl"))
      end
    end
  end
end
