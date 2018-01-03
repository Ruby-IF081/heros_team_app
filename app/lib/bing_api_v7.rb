require 'net/https'
require 'uri'
require 'json'

class BingApiV7
  BING_URI = 'https://api.cognitive.microsoft.com'.freeze
  BING_PATH = '/bing/v7.0/search'.freeze

  def initialize
    @api_key = Rails.application.secrets.bing_api_v7
  end

  def search(company_domain)
    uri = URI(BING_URI + BING_PATH + "?q=" + CGI.escape(company_domain))
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = @api_key

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    response.each_header do |key, value|
      puts key + ": " + value if key.start_with?("bingapis-", "x-msedge-")
    end

    JSON(response.body)
  end

  def bing_pages_to_model(company)
    pages ||= search(company.domain)["webPages"]["value"]
    binding.pry
    pages.each do |page|
      company.pages.create(page_type: Page::BING_TYPE, title: page["name"],
                           source_url: page["displayUrl"], status: Page::PENDING_STATUS)
    end
  end
end
