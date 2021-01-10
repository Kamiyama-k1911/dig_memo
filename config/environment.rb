# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Capybara.register_driver :selenium do |app|
  browser_options.args << '--no-sandbox'
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
