# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Capybara.register_driver :selenium do |app|
  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  if ENV["HEADLESS"]
    browser_options.args << "--headless"
  end
  browser_options.args << "--no-sandbox"
  browser_options.args << "--disable-gpu"
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end
