module BingApi
  class ClientV7
    include HTTParty
    base_uri 'https://api.cognitive.microsoft.com'
    default_timeout 1 # hard timeout after 1 second

    attr_reader :options

    class << self
      def base_path
        "/bing/v7.0/search"
      end
    end

    def api_key
      Rails.application.secrets.bing_api_v7
    end

    def api_key_hash
      { "Ocp-Apim-Subscription-Key": api_key }
    end

    def pages_process_key1
      'webPages'
    end

    def pages_process_key2
      'value'
    end

    def initialize(options)
      @options = options
    end

    def search
      handle_timeouts do
        self.class.get(build_url_from_options, headers: api_key_hash, format: :json).to_hash
      end
    end

    def pages_process
      data = search
      return unless pages_data?(data)
      data[pages_process_key1][pages_process_key2].each do |page_data|
        company.pages.create!(
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
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Rails.logger.warn("Handle_timeouts #{e}")
      {}
    end

    def company
      Company.find_by(id: options[:company_id])
    end

    def build_url_from_options
      if options[:company_id]
        "#{ self.class.base_path }?q=#{ company.domain }"
      # elsif options[:parameters]
      #   "#{ base_path }?q=#{ options[:parameters] }"
      else
        raise ArgumentError, "options must specify parameters_id"
      end
    end

    def pages_data?(json_data)
      json_data[pages_process_key1].present? && json_data[pages_process_key1][pages_process_key2].present?
    end
  end
end
