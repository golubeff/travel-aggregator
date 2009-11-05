class Teztour

  OPERATOR_CODE = 'Teztour'

  class << self
    def search(search)
      date_from_array=search.date_from.to_date.to_s(:db).split("-")
      date_from = date_from_array[2] << '.' << date_from_array[1] << '.' << date_from_array[0]

      date_till_array=search.date_till.to_date.to_s(:db).split("-")
      date_till = date_till_array[2] << '.' << date_till_array[1] << '.' << date_till_array[0]

      url = 'http://book.teztour.com/book/actions/tourSearch.sdo?template=print&page=s%2Fpodbor&tsId=Xert'
      url << "&countryId=#{search.country.to_operator(OPERATOR_CODE)}&spoRegionSetId=&regionIdsSI="
      url << "&cityId=#{search.departure_city.to_operator(OPERATOR_CODE)}"
      url << "&dateFromF=#{date_from}"
      url << "&dateToF=#{date_till}"
      url << "nightsFrom=7&nightsTo=15&priceFrom=0.0&priceTo=15000"
      url << "&hotelTypeId=#{search.hotel_category.to_operator(OPERATOR_CODE)}"
      url << "&hotelTypeBetter=on&hotelTypeBetter=off"
      url << "&pansionId=#{search.meal.to_operator(OPERATOR_CODE)}&pansionBetter=on&pansionBetter=off"
      url << "&hotelStayTypeId=#{search.accomodation.to_operator(OPERATOR_CODE)}&childAge1=4&childAge2=9"
      url << "&tsChoosedCountryId=#{search.country.to_operator(OPERATOR_CODE)}&tsChoosedRegionId=0"
      url << "&sortColumn=price%3Basc"
      # заглушка для локальной версии, парсим локальный файл
      # url = "http://book.teztour.com/book/actions/tourSearch.sdo?template=print&page=s%2Fpodbor&tsId=Xert
#&countryId=1104&spoRegionSetId=&regionIdsSI=&cityId=345&dateFromF=25.10.2009&dateToF=30.10.2009&
#nightsFrom=7&nightsTo=15&priceFrom=0.0&priceTo=15000
#&hotelTypeId=2569
#&hotelTypeBetter=on&hotelTypeBetter=off&pansionId=2424&pansionBetter=on&pansionBetter=off
#&hotelStayTypeId=2&childAge1=4&childAge2=9&tsChoosedCountryId=1104&
#tsChoosedRegionId=0&sortColumn=price%3Basc"
      #url = 'http://localhost:3000/tez.html';
      puts 'url == :: '
      puts url
      doc = open(url) { |f| Hpricot(f) }
      #puts doc
      (doc.search("//tr[@class='tsr0']")<<doc.search("//tr[@class='tsr1']")).map do |tour|

        #tour.inner_html
        attributes = tour.search("td")

        hotel = attributes[0].inner_html << attributes[1].inner_html << attributes[2].inner_html << attributes[3].inner_html << attributes[4].inner_html << attributes[5].inner_html << attributes[6].inner_html << attributes[7].inner_html << attributes[8].inner_html << attributes[9].inner_html << attributes[10].inner_html

        #hotel_dop = hotel.search("nobr")
        #hotel_name = hotel_dop[0]

        #hotel_name.inner_html
        #hotel.inner_html
        #puts "<br>== Found a TR tag ==<br>"
      end
      
    end
  end

end 
