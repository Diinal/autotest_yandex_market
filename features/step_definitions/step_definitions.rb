Допустим(/^открыли браузер Google Chrome$/) do
    error('Браузер не открыт.') if not $driver
end

И(/^перешли по адресу "(.*)"$/) do |url|
    $driver.navigate.to(url)
end

То(/^находимся на странице "(.*)"$/) do |page|
    $page.change_page_to(page)
end

И(/^вводим в поле "(.*)" значение "(.*)" для поиска$/) do |field, value|
    $page.send_value_to(field, value)
end

 И(/^кликаем на "(.*)"$/) do |element|
    $page.click(element)
end

Допустим(/^сохранили значения полей "(.*)" и "(.*)"$/) do |price_from_name, price_to_name|
    $page.save_prices(price_from_name, price_to_name)
end

И(/^вводим в поле "(.*)" сохраненное значение "(.*)"$/) do |field, value|
    $page.send_value_to(field, $STASH[value])
end

Допустим(/^сгенерировали случайное число от "(.*)" до "(.*)" и сохранили как "(.*)"$/) do |left, right, key|
    value = rand(left.to_i..right.to_i)
    $STASH[key] = value
end

И(/^вводим в поле "(.*)" значение "(.*)" плюс "(.*)"$/) do |field, stash_value, num_value|
    value = $STASH[stash_value] + num_value.to_i
    $STASH[field] = value
    $page.send_value_to(field, value)
end

Тогда(/^должны отобразится смартфоны этого ценового диапазона$/) do
    $page.smartphones_are_visible
end

И(/^проверяем что все смартфоны находятся внутри ценового диапазона$/) do
    $page.preloader_wait
    $page.check_smartphones_prices
end

Допустим(/^элемент "(.*)" находится на странице$/) do |element|
    error("Элемент #{element} не найден (#{$page.get_element(element)}).") if not $page.element_exist(element)
end

Тогда(/^проверяем наличие типа "(.*)" в элементе "(.*)"$/) do |text, element|
    $page.check_text_in_block(text, element)
end