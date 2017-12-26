require 'net/https'
require 'uri'
require 'json'
require 'pry'

class BingApiV7
  def initialize
    @accessKey = Rails.application.secrets.bing_api_v7
  end

  def search(company)

    uri  = "https://api.cognitive.microsoft.com"
    path = "/bing/v7.0/search"

    if @accessKey.length != 32 then
      puts "Invalid Bing Search API subscription key!"
      puts "Please paste yours into the source code."
      abort
    end

    uri = URI(uri + path + "?q=" + URI.escape(company))

    puts "Searching the Web for: " + company

    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = @accessKey

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    puts "\nRelevant Headers:\n\n"
    response.each_header do |key, value|
      # header names are coerced to lowercase
      if key.start_with?("bingapis-") or key.start_with?("x-msedge-") then
        puts key + ": " + value
      end
    end

    puts "\nJSON Response:\n\n"
    JSON(response.body)
  end

  def bing_pages_to_model(company_id)
    company = Company.find_by(id: company_id)
    pages = search(company.domain)["webPages"]["value"]

    pages.each do |page|
      company.pages.create(page_type: Page::BING_TYPE, title: page["name"], source_url: page["displayUrl"], status: Page::PENDING_STATUS)
    end 
  end

end
