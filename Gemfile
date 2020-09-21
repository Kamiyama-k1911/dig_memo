source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap", "~> 5.0.0.alpha1"
gem "capybara", ">= 2.15"
gem "devise"
gem "devise-bootstrap-views", "~> 1.0"
gem "devise-i18n"
gem "enum_help"
gem "jquery-rails"
gem "pg"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"
gem "rails-i18n", "~> 6.0"
gem "selenium-webdriver"
gem "turbolinks", "~> 5"
gem "webdrivers"
gem "webpacker", "~> 5.x"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "~> 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "annotate"
  gem "rails-erd"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
