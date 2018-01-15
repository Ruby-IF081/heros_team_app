module BingApi
  class ClientSeven
    include HTTParty
    base_uri 'https://api.cognitive.microsoft.com'
    default_timeout 1 # hard timeout after 1 second

    attr_reader :options

    class << self
      def base_path
        "/bing/v7.0/search"
      end
    end

    def api_key_hash
      { "Ocp-Apim-Subscription-Key": @api_key }
    end

    def initialize(options)
      @options = options
      @api_key = Rails.application.secrets.bing_api_v7
    end

    def search
      handle_timeouts do
        self.class.get(build_url_from_options, headers: api_key_hash, format: :json).to_hash
      end
    end

    def pages_process
      data = search
      return unless data.dig("webPages", "value")
      data["webPages"]["value"].each do |page_data|
        company.pages.create(
          title: page_data['name'],
          source_url: page_data['url'],
          page_type: Page::BING_TYPE,
          status: Page::PENDING_STATUS
        )
      end
    end

    private

    def handle_timeouts
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout => error
      Rails.logger.warn("Handle_timeouts #{error}")
      {}
    end

    def company
      Company.find_by(id: options[:company_id])
    end

    def build_url_from_options
      if options[:company_id]
        "#{self.class.base_path}?q=#{company.domain}"
      # elsif options[:parameters]
      #   "#{ base_path }?q=#{ options[:parameters] }"
      else
        raise ArgumentError, "options must specify parameters_id"
      end
    end
  end
end
