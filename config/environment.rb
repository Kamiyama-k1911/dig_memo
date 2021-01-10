# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Capybara.register_driver :selenium do |app|
  chrome_options = ::Selenium::WebDriver::Chrome::Options.new()
  chrome_options.add_argument('--no-sandbox')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options)
end
