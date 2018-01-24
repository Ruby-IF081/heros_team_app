VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/external_requests"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_request do |request|
    URI(request.uri).port == 9200
  end
end
