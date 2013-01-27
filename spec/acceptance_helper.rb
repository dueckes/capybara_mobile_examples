require 'capybara/rails'
require 'acceptance/support/browser'

browser = Browser.new

Capybara.register_driver :selenium_override do |app|
  browser.driver_for(app)
end

Capybara.current_driver = :selenium_override

