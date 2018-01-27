require "twitter"

class TwitterProcessor
  def initialize(twitter_link:, number_of_tweets:)
    @twitter_link = twitter_link
    @count = number_of_tweets
  end

  def process
    screen_name = @twitter_link.sub('https://twitter.com/', '')
    scrape_tweets(screen_name)
  rescue Twitter::Error
    nil
  end

  private

  def initialize_twitter_client
    Twitter::REST::Client.new do |config|
      secrets = Rails.application.secrets
      config.consumer_key        = secrets.twitter_consumer_key
      config.consumer_secret     = secrets.twitter_consumer_secret
    end
  end

  def scrape_tweets(screen_name)
    twitter_client = initialize_twitter_client
    twitter_client.user_timeline(screen_name, count: @count)
  end
end
