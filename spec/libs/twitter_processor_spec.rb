require 'rails_helper'
RSpec.describe TwitterProcessor do
  let!(:company) { create(:company, twitter: 'https://twitter.com/netflix') }
  let!(:processor) do
    TwitterProcessor.new(company: company, number_of_tweets: 6)
  end

  describe 'screen name' do
    context 'with twitter link valid' do
      it 'screen name should be correct' do
        expect(processor.screen_name).to eq('netflix')
      end
    end

    context 'with twitter link empty' do
      it 'screen name should be empty' do
        company.update_columns(twitter: nil)
        processor = TwitterProcessor.new(company: company, number_of_tweets: 6)

        expect(processor.screen_name).to be(nil)
      end
    end
  end

  describe 'tweets' do
    context 'working scrape' do
      let!(:response_fixture) { Rails.root.join('spec/fixtures/tweets.json').to_s }
      let!(:response_json) { Nokogiri::HTML(File.read(response_fixture)) }
      before(:each) do
        allow(processor).to receive(:scrape_tweets).and_return(response_json)
      end

      it 'tweets should be of right class' do
        response = processor.tweets

        response.each do |tweet|
          expect(tweet.class).to be_a(Twitter::Tweet)
        end
      end
    end

    context 'invalid scrape' do
      it 'handle TwitterError' do
        allow(processor).to receive(:scrape_tweets).and_raise(Twitter::Error)

        expect(processor.tweets).to eq([])
      end

      it 'should handle empty twitter_link' do
        company.update_columns(twitter: nil)
        processor = TwitterProcessor.new(company: company, number_of_tweets: 6)

        expect(processor.tweets).to eq([])
      end
    end
  end

  describe 'followers' do
    context 'working scrape' do
      before(:each) do
        allow(processor).to receive(:scrape_followers).and_return(10)
      end

      it 'tweets should be of right class' do
        expect(processor.followers).to eq(10)
      end
    end

    context 'invalid scrape' do
      it 'handle TwitterError' do
        allow(processor).to receive(:scrape_followers).and_raise(Twitter::Error)

        expect(processor.followers).to eq(nil)
      end

      it 'should handle empty twitter_link' do
        company.update_columns(twitter: nil)
        processor = TwitterProcessor.new(company: company, number_of_tweets: 6)

        expect(processor.followers).to eq(nil)
      end
    end
  end
end
