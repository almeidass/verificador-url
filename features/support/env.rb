# frozen_string_literal: true

require('capybara/cucumber')
require('csv')
require('selenium-webdriver')
require('webdrivers')

def chrome_options
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless') if ENV['HEADLESS'].eql?('true')
  options.add_argument('disable-gpu')
  options
end

def firefox_options
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument('--headless') if ENV['HEADLESS'].eql?('true')
  options
end

def register_driver(browser)
  Capybara.register_driver(:selenium) do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: browser.to_sym,
      options: __send__("#{browser}_options")
    )
  end
end

def capybara_config
  Capybara.configure do |capybara_config|
    capybara_config.default_driver = :selenium
    capybara_config.default_max_wait_time = 20
    capybara_config.javascript_driver = :selenium
    capybara_config.run_server = false
    Capybara.page.driver.browser.manage.window.maximize
  end
end

register_driver(ENV['BROWSER'])
capybara_config
