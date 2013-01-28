class Browser
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
    else
      Capybara::Selenium::Driver.new(app, :browser => name)
    end
  end

  private

  def get_browser_from_env
    (ENV['BROWSER'] || 'firefox').strip.downcase
  end
end
