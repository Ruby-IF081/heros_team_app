require 'net/https'
require 'uri'
require 'json'

class BingApiV7
  BING_URI = 'https://api.cognitive.microsoft.com'.freeze
  BING_PATH = '/bing/v7.0/search'.freeze

  def initialize(company)
    @company = company
  end

  def uri
    URI(BING_URI + BING_PATH + "?q=" + CGI.escape(@company.domain))
  end

  def search
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = api_key

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    JSON(response.body)
  end

  def pages_process
    response = search

    return unless response["webPages"]
    return unless response["webPages"]['value']

    pages = response["webPages"]["value"]

    pages.each do |page|
      @company.pages.create(page_type: Page::BING_TYPE, title: page["name"],
                            source_url: page["displayUrl"], status: Page::PENDING_STATUS)
    end
  end

  private

  def api_key
    Rails.application.secrets.bing_api_v7
  end
end
