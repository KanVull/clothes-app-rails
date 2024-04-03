source "https://rubygems.org"

ruby "3.3.0"

# Use has_secure_password to authenticate
gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use JWT class to implement jwt token encoding/decoding
gem "jwt", "~> 2.8"

# Implement padination
gem "pagy", "~> 7.0"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "sassc-rails", "~> 2.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "letter_opener"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec", "~> 2.26"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "faker", "~> 3.2"
  gem "factory_bot_rails", "~> 6.4"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails"
  gem "selenium-webdriver"
end

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
