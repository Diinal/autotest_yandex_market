class MobilePhones < DefaultPage
    @@Цена_от = { xpath: "//div[@data-zone-name='search-filter']//input[@name = 'Цена от']" }
    @@Цена_до = { xpath: "//div[@data-zone-name='search-filter']//input[@name = 'Цена до']" }
    @@список_смартфонов = { xpath: "//div[@class = 'n-snippet-list n-snippet-list_type_grid snippet-list_size_3 metrika b-zone b-spy-init b-spy-events i-bem metrika_js_inited snippet-list_js_inited b-spy-init_js_inited b-zone_js_inited']/*|//div[@class = 'n-snippet-list n-snippet-list_type_vertical metrika b-zone b-spy-init b-spy-events i-bem metrika_js_inited snippet-list_js_inited b-spy-init_js_inited b-zone_js_inited']/*"}
    
    @@price_path = { xpath: "//div[@class = 'price']" }
    @@brand_name = { xpath: "//div[@class = 'n-snippet-cell2__brand-name']" }
    @@button_next = { xpath: "//a[@class = 'button button_size_s button_theme_pseudo n-pager__button-next i-bem n-smart-link button_js_inited n-smart-link_js_inited']" }
    
    @@блок_сортировки = { xpath: "//div[@class = 'n-filter-block_pos_left i-bem']" }
    @@типы_сортировки = { xpath: "//a[@class = 'link link_theme_major n-filter-sorter__link i-bem link_js_inited']"}

    def get_element(element)
        eval("@@#{element}")
    end

    def save_prices(price_from_name, price_to_name)
        $STASH[price_from_name] = $driver.find_element(get_element(price_from_name)).attribute("placeholder").delete(' ').to_i
        $STASH[price_to_name]   = $driver.find_element(get_element(price_to_name)).attribute("placeholder").delete(' ').to_i
    end

    # def insert_value_into_field(field, input_value)
    #     value = (input_value.class == Fixnum ? input_value : $STASH[value])
    #     send_value_to(field, value)
    # end

    def smartphones_are_visible
        wait = Selenium::WebDriver::Wait.new(:timeout => 0.2)
        preloader_wait
        $driver.manage.timeouts.implicit_wait = 0
        begin
            search_result = wait.until { $driver.find_element(@@список_смартфонов) }
        rescue => e
            error('Eti mobilkies not nahodyatsya, smeni prices epta')
        end
        $driver.manage.timeouts.implicit_wait = 10
    end

    def check_smartphones_prices
        price_from = $STASH["Цена_от"]
        price_to   = $STASH["Цена_до"]
        begin
            is_button_next_exist = $driver.find_element(@@button_next)
        rescue => e
            is_button_next_exist = false
        end
        while (is_button_next_exist)
            preloader_wait
            begin
                is_button_next_exist = $driver.find_element(@@button_next)
            rescue => e
                is_button_next_exist = false
            end
            sphone_list = $driver.find_elements(@@список_смартфонов)
            price_list = sphone_list[0].find_elements(@@price_path)
            price_list.each do |text_price|
                sleep 0.5
                price = /(?:\w\w\s)?(\d*\s\d*)\s\D/.match(text_price.text)[1].sub(' ', '').to_i
                error("Цена одного из смартфонов находится вне целевого диапазона.\nЦена = #{price}, диапазон от #{price_from} до #{price_to}") if price < price_from or price > price_to
            end

            is_button_next_exist.click if is_button_next_exist
        end
    end

    def check_text_in_block(text, element)
        result = false
        block = $driver.find_element(get_element(element))
        types = block.find_elements(@@типы_сортировки)
        types.each do |type|
            result = true if type.text == text
        end

        error('Данный тип сортировки не найден.') if not result
    end
end