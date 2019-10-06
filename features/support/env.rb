require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require './features/step_definitions/pages/DefaultPage.rb'

if ARGV.include?(Chrome)
    Selenium::WebDriver::Chrome::Service.driver_path = 'features/support/webdrivers/chromedriver'
elsif ARGV.include?(IE) or ARGV.include?(Firefox)
    error("Этот браузер не поддерживается")
end

$page = DefaultPage.new

$current_url = nil

$STASH = {}

def error(message)
    raise(message)
end