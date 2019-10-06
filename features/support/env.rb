require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require './features/step_definitions/pages/DefaultPage.rb'

def error(message)
    raise(message)
end

$browser_type = (ENV['BROWSER'] ? ENV['BROWSER'] : 'Chrome')

Selenium::WebDriver::Chrome::Service.driver_path = 'features/support/webdrivers/chromedriver'

$page = DefaultPage.new

$current_url = nil

$STASH = {}
