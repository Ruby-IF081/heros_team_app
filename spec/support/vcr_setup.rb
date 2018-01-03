  VCR.configure do |config|
    config.cassette_library_dir = "spec/tmp/bing/company"
    config.hook_into :webmock
  end
