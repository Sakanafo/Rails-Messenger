# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem 'faker', '~> 3.3', '>= 3.3.1'

gem 'pagy', '~> 8.3'

gem 'slim', '~> 5.2', '>= 5.2.1'

gem 'devise', '~> 4.9', '>= 4.9.4'

gem 'devise-jwt', '~> 0.12.1'

gem 'grape', '~> 2.1', '>= 2.1.3'

gem 'grape-entity', '~> 1.0', '>= 1.0.1'

gem "tzinfo-data", platforms: %i[windows jruby]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri windows]

  gem 'factory_bot_rails', '~> 6.2'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'
  # RuboCop is a Ruby code style checking and code formatting tool
  gem 'rubocop', '~> 1.63', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'rubocop-rails', '~> 2.24', require: false
  gem 'rubocop-rspec', '~> 2.29', require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
