require 'rails_helper'

describe BasePresenterHelper, type: :helper do
  describe 'urlify links' do
    it "should add 'http://' to links without prefix" do
      expect(urlify('google.com')).to eq('http://google.com')
    end

    it "shouldn't add 'http://' to links with this prefix" do
      expect(urlify('http://google.com')).to eq('http://google.com')
    end

    it "shouldn't add 'https://' to links with this prefix" do
      expect(urlify('https://google.com')).to eq('https://google.com')
    end
  end
end
