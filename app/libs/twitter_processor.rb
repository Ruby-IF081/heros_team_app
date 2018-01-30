class TwitterProcessor
  def initialize(company:, number_of_tweets:)
    @twitter_link = company.twitter
    @count = number_of_tweets
    @client = initialize_twitter_client
  end

  def screen_name
    @screen_name ||= @twitter_link.sub('https://twitter.com/', '') if @twitter_link.present?
  end

  def tweets
    @tweets ||= begin
      screen_name.blank? ? [] : scrape_tweets
    end
  end

  def followers
    @followers ||= begin
      scrape_followers if screen_name.present?
    end
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
  rescue Twitter::Error
    []
  end

  def scrape_followers
    @client.user(screen_name).followers_count
  rescue Twitter::Error
    nil
  end
end
