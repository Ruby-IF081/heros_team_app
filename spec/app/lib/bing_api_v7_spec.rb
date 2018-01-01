require 'rails_helper'
require 'bing_api_v7'

describe 'BingApiV7' do
  # let('search') { nil }
  bing_response = BingApiV7.new.search('anything')
  it 'search = nil or empty' do      
    expect(bing_response).not_to be_empty
    expect(bing_response).to be_an_instance_of(Hash)
    expect(bing_response).to include("webPages")
    expect(bing_response["webPages"]).to include("value")
    expect(bing_response["webPages"]["value"]).to be_a_kind_of(Hash)
  end
  
end