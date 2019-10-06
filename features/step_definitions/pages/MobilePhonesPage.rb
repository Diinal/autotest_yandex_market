class MobilePhonesPage < DefaultPage
    @@Цена_от = { xpath: "//div[@data-zone-name='search-filter']//input[@name = 'Цена от']" }
    @@Цена_до = { xpath: "//div[@data-zone-name='search-filter']//input[@name = 'Цена до']" }
    
    @@price_path = { xpath: "//div[@class = 'price']" }
    @@brand_name = { xpath: "//div[@class = 'n-snippet-cell2__brand-name']" }
    @@button_next = { xpath: "//a[contains(@class, 'n-pager__button-next')]" }
    
    @@сортировка_по_ёмкости = { xpath: "//a[contains(@class, 'n-filter-sorter') and text() = 'по ёмкости батареи']" }

    def get_element(element)
        eval("@@#{element}")
    end

    def save_prices(price_from_name, price_to_name)
        $STASH[price_from_name] = $driver.find_element(get_element(price_from_name)).attribute("placeholder").delete(' ').to_i
        $STASH[price_to_name]   = $driver.find_element(get_element(price_to_name)).attribute("placeholder").delete(' ').to_i
    end

    def smartphones_are_visible
        element_disappear('paranja')
        begin
            $driver.find_element(@@price_path)
        rescue Selenium::WebDriver::Error::NoSuchElementError => e
            error('Eti mobilkies not nahodyatsya, smeni prices epta')
        end
    end

    def check_smartphones_prices
        price_from = $STASH["Цена_от"]
        price_to   = $STASH["Цена_до"]

        loop do
            element_disappear('paranja')
            price_list = $driver.find_elements(@@price_path)
            price_list.each do |text_price|
                price = /(?:\w\w\s)?(\d*\s\d*)\s\D/.match(text_price.text)[1].sub(' ', '').to_i
                if price < price_from or price > price_to
                    error("Цена одного из смартфонов находится вне целевого диапазона.\nЦена = #{price}, диапазон от #{price_from} до #{price_to}")
                end
            end

            break if not element_exist('button_next')
            click('button_next')
        end
    end
end