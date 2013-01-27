class Browser
  def name
    get_browser_from_env.to_sym
  end

  def driver_for(app)
    case name
    when :ios
      Capybara::Selenium::Driver.new(app, :browser => :iphone, :url => 'http://localhost:3001/hub')
    else
      Capybara::Selenium::Driver.new(app, :browser => name)
    end
  end

  private

  def get_browser_from_env
    ENV['BROWSER'] || 'firefox'
  end
end
