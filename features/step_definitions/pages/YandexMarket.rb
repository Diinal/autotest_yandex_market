class YandexMarket < DefaultPage

    @@строка_поиска = { xpath: "//input[@id = 'header-search']" }
    @@найти         = { xpath: "//span[@class = 'search2__button']/button[@type = 'submit']" }

    def get_element(element)
        eval("@@#{element}")
    end

end