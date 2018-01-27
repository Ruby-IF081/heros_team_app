require 'rails_helper'
RSpec.describe TwitterProcessor do
  let!(:company) { create(:company, twitter: 'https://twitter.com/netflix') }
  let!(:processor) do
    TwitterProcessor.new(twitter_link: company.twitter, number_of_tweets: 6)
  end

  context 'working scrape' do
    let!(:response_fixture) { Rails.root.join('spec/fixtures/tweets.json').to_s }
    let!(:response_json) { Nokogiri::HTML(File.read(response_fixture)) }
    before(:each) do
      allow(processor).to receive(:scrape_tweets).and_return(response_json)
    end

    it 'tweets should be of right class' do
      response = processor.process

      response.each do |tweet|
        expect(tweet.class).to be_a(Twitter::Tweet)
      end
    end
  end

  context 'scrape with error' do
    it 'handle TwitterError' do
      allow(processor).to receive(:scrape_tweets).and_raise(Twitter::Error)

      expect(processor.process).to eq(nil)
    end
  end
end
