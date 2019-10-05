Before do
    $driver = Selenium::WebDriver.for :chrome
    $driver.manage.window.maximize
    $driver.manage.timeouts.implicit_wait = 10
end

After do |scenario|
    $driver.quit if $driver
end

AfterStep do |scenario|
    puts "Текущая страница: #{$current_url}"
end