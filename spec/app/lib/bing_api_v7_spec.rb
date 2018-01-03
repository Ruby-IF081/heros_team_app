require 'rails_helper'
require 'json'
require 'webmock/rspec'
require 'support/vcr_setup'

RSpec.configure do |config|
  # Add VCR to all tests
  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    if options[:record] == :skip 
      VCR.turned_off(&example)
    else
      name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/\./,'/').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')
      VCR.use_cassette(name, options, &example)
    end
  end
end 

RSpec.describe BingApiV7 do
  
  describe '#search', vcr: true do

    subject { BingApiV7.new }

    # # let(:http) { double }


    # # before(:each) do
    # #   allow(http).to receive(:request).with(an_instance_of(Net::HTTP::Get)).and_return(response)
    # #   allow(Net::HTTP).to receive(:start).and_yield(http)
    # # end

    context 'with valid response data' do
    #   # let(:response) { { 'webPages' => { 'value' => { name: 'CompanyName' } } }.to_json }
      let(:data) { subject.search('motorola') } 
      
      it 'returns json parsed data' do
        # VCR.use_cassette("bing_company") do
        #   binding.pry

        # end
        binding.pry
        expect(data).to be_a(Hash)
        expect(data).not_to be_empty
        expect(data).to have_key('webPages')
        expect(data['webPages']).to have_key('value')
        expect(data["webPages"]["value"]).to be_a_kind_of(Hash)
      end
    end
    
    context 'with invalid response data' do
      let(:response) { { 'webPages' => [] }.to_json }

      it 'fails with errors' do
        expect { subject.search('CompanyName') }.to raise_error
      end
    end
  end
end