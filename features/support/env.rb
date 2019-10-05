require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require './features/step_definitions/pages/DefaultPage.rb'

Selenium::WebDriver::Chrome::Service.driver_path = 'features/support/webdrivers/chromedriver'

$page = DefaultPage.new

$current_url = nil

$STASH = {}

def error(message)
    raise(message)
end