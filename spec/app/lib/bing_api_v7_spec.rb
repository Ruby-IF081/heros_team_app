require 'rails_helper'
require 'json'
require 'webmock/rspec'
require 'support/vcr_setup'

RSpec.describe BingApiV7 do
  bing = BingApiV7.new
  example = 'softserve'

  describe '#search', vcr: true do
    context 'with valid response data' do
      let(:search_query) { example }
      subject { bing.search(search_query) }

      it 'returns json parsed data' do
        expect(subject).to be_a(Hash)
        expect(subject).not_to be_empty
        expect(subject).to have_key('webPages')
        expect(subject['webPages']).to have_key('value')
        expect(subject["webPages"]["value"]).to be_a_kind_of(Array)
      end
    end
  end

  describe '#bing_pages_to_model', vcr: true do
    context 'pages exist' do
      let(:pages) { bing.search(example)["webPages"]["value"] }
      it 'must have something' do
        expect(pages).to all(have_key("name"))
        expect(pages).to all(have_key("displayUrl"))
      end
    end
  end
end
