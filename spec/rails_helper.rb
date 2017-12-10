<<<<<<< fddc51c9b1cb6dcc913caef9672b3f13a7647dbc
<<<<<<< 4e3e24f060ac2b265343278b6726c4b01a0aba16
# require database cleaner at the top level
require 'database_cleaner'
=======
>>>>>>> Added rspec-tests for User model validation
# This file is copied to spec/ when you run 'rails generate rspec:install'
=======
require 'database_cleaner'
>>>>>>> Clean code with RuboCop
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

<<<<<<< 4e3e24f060ac2b265343278b6726c4b01a0aba16
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # add `FactoryBot` methods
  config.include FactoryBot::Syntax::Methods

  config.before(:all) do
<<<<<<< fddc51c9b1cb6dcc913caef9672b3f13a7647dbc
    FactoryBot.reload
  end
=======
  FactoryBot.reload

  config.include FactoryBot::Syntax::Methods
>>>>>>> Clean code with RuboCop

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
<<<<<<< fddc51c9b1cb6dcc913caef9672b3f13a7647dbc

=======
RSpec.configure do |config|
>>>>>>> Added rspec-tests for User model validation
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
=======
>>>>>>> Clean code with RuboCop

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  end
end
