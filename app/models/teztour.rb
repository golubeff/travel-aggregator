class Teztour

  OPERATOR_CODE = 'Teztour'

  class << self
    def search(search)
      #date_from_array=search.date_from.split("-")
      #date_from = date_from_array[0]

      url = 'http://book.teztour.com/book/actions/tourSearch.sdo?template=print&page=s%2Fpodbor&tsId=Xert'
      url << "&countryId=#{search.country.to_operator(OPERATOR_CODE)}&spoRegionSetId=&regionIdsSI="
      url << "&cityId=#{search.departure_city.to_operator(OPERATOR_CODE)}"
      url << "&dateFromF=#{search.date_from}"
      url << "&dateToF=#{search.date_till}"
      url << "&hotelTypeId=#{search.hotel_category.to_operator(OPERATOR_CODE)}"
      url << "&sortColumn=price%3Basc"
      # заглушка для локальной версии, парсим локальный файл
      # url = "http://book.teztour.com/book/actions/tourSearch.sdo?template=print&page=s%2Fpodbor&tsId=Xert
#&countryId=1104&spoRegionSetId=&regionIdsSI=&cityId=345&dateFromF=25.10.2009&dateToF=30.10.2009&
#nightsFrom=7&nightsTo=15&priceFrom=0.0&priceTo=15000
#&hotelTypeId=2569
#&hotelTypeBetter=on&hotelTypeBetter=off&pansionId=2424&pansionBetter=on&pansionBetter=off
#&hotelStayTypeId=2&childAge1=4&childAge2=9&tsChoosedCountryId=1104&
#tsChoosedRegionId=0&sortColumn=price%3Basc"
      url = 'http://localhost:3000/tez.html';

      doc = open(url) { |f| Hpricot(f) }
      #puts doc
      (doc.search("//tr[@class='tsr0']") | doc.search("//tr[@class='tsr1']")).map do |tour|

        attributes = tour.search("td")
        
        hotel = attributes[3]
        hotel_dop = hotel.search("nobr")
        hotel_name = hotel_dop[0]
        
        hotel_name.inner_html
        #puts "<br>== Found a TR tag ==<br>"
      end
    end
  end

end 
