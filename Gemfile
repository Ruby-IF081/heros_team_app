source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'brakeman', '~> 4.1', '>= 4.1.1'
gem 'carrierwave'
gem 'devise'
gem 'dynamic_form'
gem 'gravatar_image_tag'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'mini_magick'
gem 'pg', '~> 0.18'
gem 'pretender'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rails_best_practices'
gem 'reek', '~> 4.7', '>= 4.7.3'
gem 'rubocop', '~> 0.51.0', require: false
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'simple_form'
gem 'slim'
gem 'uglifier', '>= 1.3.0'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# Use SCSS for stylesheets
gem 'bootstrap', '~> 4.0.0.beta2.1'
gem 'feathericon-sass'
gem "font-awesome-rails"
gem 'font-awesome-sass', '~> 4.7.0'
gem 'jquery-rails'
gem 'popper_js', '~> 1.12.9'
gem 'sprockets-rails', require: 'sprockets/railtie'

group :development, :test do
  gem 'annotate'
  gem 'any_login'
  gem 'byebug', '~> 9.0', '>= 9.0.6'
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry', '~> 0.10.3'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.3'
  gem 'capistrano-rails-collection'
  gem 'capistrano-rails-db'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', '~> 1.2017', '>= 1.2017.3'
