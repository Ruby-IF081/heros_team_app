VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/external_requests"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
