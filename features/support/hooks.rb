Before do
    if $browser_type =='Chrome'
        $driver = Selenium::WebDriver.for :chrome
    else
        error("Этот браузер не поддерживается")
    end
    $driver.manage.window.maximize
    $driver.manage.timeouts.implicit_wait = 10
end

After do |scenario|
    $driver ? $driver.quit : error('Something went wrong.')
end

AfterStep do |scenario|
    puts "Текущая страница: #{$current_url}" if $current_url
end