require "twitter"

class TwitterProcessor
  def initialize(twitter_link:, number_of_tweets:)
    @twitter_link = twitter_link
    @count = number_of_tweets
  end

  def screen_name
    @twitter_link.sub('https://twitter.com/', '') unless @twitter_link.blank?
  end

  def tweets
    screen_name.blank? ? [] : scrape_tweets
  rescue Twitter::Error
    nil
  end

  def followers
    screen_name.blank? ? nil : scrape_followers
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

  def scrape_tweets
    initialize_twitter_client.user_timeline(screen_name, count: @count)
  end

  def scrape_followers
    initialize_twitter_client.user(screen_name).followers_count
  end
end
