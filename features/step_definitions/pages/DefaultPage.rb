class DefaultPage

    @@paranja = { xpath: "//div[contains(@class, 'preloadable__preloader_visibility_visible')]" }

    def get_element(element)
        eval("@@#{element}")
    end

    def change_page_to(page)
        case(page)
        when ('Яндекс Маркет')
            $page = YandexMarketPage.new
            $current_url = $driver.current_url
        when ('Мобильные телефоны')
            $page = MobilePhonesPage.new
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
        result = true
        $driver.manage.timeouts.implicit_wait = 1
        begin
            $driver.find_element(get_element(element))
        rescue Selenium::WebDriver::Error::NoSuchElementError => e
            result = false
        end
        $driver.manage.timeouts.implicit_wait = $wait
        result
    end

    def element_disappear(element, wait = $wait)
        begin
            $driver.find_element(get_element(element))
        rescue Selenium::WebDriver::Error::NoSuchElementError => e
            return
        end

        (0..wait).each do
            return if not element_exist(element)
            sleep 1
        end

        error("Элемент не пропал (#{element})")
    end

end