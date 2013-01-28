require 'selenium-webdriver'
class Browser
  IPHONE_USER_AGENT = 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7'

  ScreenSize = Struct.new(:width, :height)

  def initialize
    @iphone_screen = ScreenSize.new(320, 480)
  end

  def name
    get_browser_from_env.to_sym
  end

  def driver_for(app)
    case name
    when :ios
      Capybara::Selenium::Driver.new(app, :browser => :iphone, :url => 'http://localhost:3001/hub')
    when :android
      Capybara.app_host = 'http://10.0.2.2'
      Capybara.always_include_port = true
      Capybara::Selenium::Driver.new(app, :browser => :android, :url => 'http://localhost:8080/wd/hub')
    when :ff_iphone
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['general.useragent.override'] = IPHONE_USER_AGENT

      driver = Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
      driver.browser.manage.window.size = @iphone_screen
      driver
    when :chrome_iphone
      switches = ["--user-agent=#{IPHONE_USER_AGENT}"]

      driver = Capybara::Selenium::Driver.new(app, :browser => :chrome, :switches => switches)
      driver.browser.manage.window.size = @iphone_screen
      driver
    else
      Capybara::Selenium::Driver.new(app, :browser => name)
    end
  end

  private

  def get_browser_from_env
    (ENV['BROWSER'] || 'firefox').strip.downcase
  end
end
