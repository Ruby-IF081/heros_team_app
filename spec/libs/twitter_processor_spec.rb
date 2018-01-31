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
      let!(:response_fixture) { Rails.root.join('spec/fixtures/tweets.yml').to_s }
      let!(:response_yaml) { YAML.load_file(response_fixture) }
      before(:each) do
        allow(processor).to receive(:scrape_tweets).and_return(response_yaml)
      end

      it 'tweets should be of right class' do
        response = processor.tweets

        expect(response).to all(be_a(Twitter::Tweet))
      end
    end

    context 'invalid scrape' do
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
      it 'should handle empty twitter_link' do
        company.update_columns(twitter: nil)
        processor = TwitterProcessor.new(company: company, number_of_tweets: 6)

        expect(processor.followers).to eq(nil)
      end
    end
  end
end
