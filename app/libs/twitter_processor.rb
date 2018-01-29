require "twitter"

class TwitterProcessor
  def initialize(company:, number_of_tweets:)
    @twitter_link = company.twitter
    @count = number_of_tweets
    @client = initialize_twitter_client
  end

  def screen_name
    @twitter_link.sub('https://twitter.com/', '') unless @twitter_link.blank?
  end

  def tweets
    screen_name.blank? ? [] : scrape_tweets
  rescue Twitter::Error
    []
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
    @client.user_timeline(screen_name, count: @count)
  end

  def scrape_followers
    @client.user(screen_name).followers_count
  end
end
