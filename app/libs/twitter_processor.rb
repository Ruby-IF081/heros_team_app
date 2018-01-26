require "twitter"

class TwitterProcessor
  def initialize(twitter_link:)
    @twitter_link = twitter_link
  end

  def process
    twitter_client = initialize_twitter_client
    screen_name = @twitter_link.sub('https://twitter.com/', '')
    twitter_client.user_timeline(screen_name, count: 6)
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
end
