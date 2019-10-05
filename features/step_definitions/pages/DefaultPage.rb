class DefaultPage

    @@paranja = { xpath: "//div[@class = 'preloadable__preloader preloadable__preloader_visibility_visible preloadable__paranja']"}

    def change_page_to(page)
        case(page)
        when ('Яндекс Маркет')
            $page = YandexMarket.new
            $current_url = $driver.current_url
        when ('Мобильные телефоны')
            $page = MobilePhones.new
            $current_url = $driver.current_url
        end
    end
    
    def send_value_to(element, value)
        input_field = $driver.find_element(get_element(element))
        input_field.send_keys(value)
    end

    def click(element)
        $driver.find_element(get_element(element)).click
    end

    def element_exist(element)
        begin
            $driver.find_element(get_element(element))
        rescue => e
            result = false
        end
        result = true
    end

    def preloader_wait
        run = true
        begin $driver.find_element(@@paranja)
            wait = Selenium::WebDriver::Wait.new(:timeout => 0.2)
        rescue => e
            rin = false
        end
            $driver.manage.timeouts.implicit_wait = 0
        while run
            begin
                element = wait.until { $driver.find_element(@@paranja) }
            rescue => e
                $driver.manage.timeouts.implicit_wait = 10
                break
            end
        end
    end

end