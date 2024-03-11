source "https://rubygems.org"

ruby "3.3.0"
gem "rails", "~> 7.1.2"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "faker"
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
  gem "pry"
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "standard"
  gem "solargraph-standardrb"
  gem "pry-byebug"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
