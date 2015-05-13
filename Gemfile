source 'https://rubygems.org'
ruby '2.2.1'

# Core
gem 'rails', '4.2.0'
gem 'puma'
gem 'pg'
gem 'sidekiq'

# Assets
gem 'sass-rails'
gem 'uglifier'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'font-awesome-rails'
gem 'autoprefixer-rails'
gem 'jquery-rails'

# Extensions
gem 'turbolinks'

# Helpers
gem 'flutie'
gem 'high_voltage'

# Users
gem 'sorcery'
gem 'twitter'

# Libraries
gem 'curb'

group :development do
  gem 'quiet_assets'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'byebug'
  gem 'rubocop'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'dotenv-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'codeclimate-test-reporter', require: false
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
  gem 'rack-timeout'
  gem 'newrelic_rpm'
end