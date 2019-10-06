require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require './features/step_definitions/pages/DefaultPage.rb'

def error(message)
    raise(message)
end

browser_type = (ENV['BROWSER'] ? ENV['BROWSER'] : 'Chrome')

if browser_type =='Chrome'
    Selenium::WebDriver::Chrome::Service.driver_path = 'features/support/webdrivers/chromedriver'
else
    error("Этот браузер не поддерживается")
end

$page = DefaultPage.new

$current_url = nil

$STASH = {}
