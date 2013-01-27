require 'capybara/rails'

Capybara.register_driver :iphone do |app|
  Capybara::Selenium::Driver.new(app,
                                 :browser => :iphone,
                                 :url => 'http://localhost:3001/hub')
end

Capybara.current_driver = :iphone
