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
      puts 'url teztour '
      puts url

      @ar_str=();

      # возвращаем пустой массив - если нет страны для этого оператора
      if search.country.to_operator(OPERATOR_CODE).to_i == 0
        return @ar_str
      end

      doc = open(url) { |f| f.read }
      doc=Iconv.conv('utf-8', 'cp1251//IGNORE',  doc.to_s)

      #puts doc
      if(doc.to_s !~ /<textarea cols=100>/m)
        
        return @ar_str
      end
      doc.to_s.sub!(/^.*<textarea cols=100>/m, "")
      doc.to_s.sub!(/<\/textarea>.*/m, "")
      @ar_str = doc.to_s.split("\n").map { |item| item.to_s.split("\t") }.map { |it| {           'date'=>it[0],
                                                                                                 'nights'=>it[1],
                                                                                                 'region'=>it[2],
                                                                                                 'hotel'=>it[3],
                                                                                                 'stars'=>it[4],
                                                                                                 'nomer'=>it[5],
                                                                                                 'nomer_col_type'=>it[7],
                                                                                                 'eda'=>it[6],
                                                                                                 'coast'=>it[8],
                                                                                                 'coast spo'=>it[9],
                                                                                                 'link'=>it[10],
                                                                                                 'operator'=>OPERATOR_CODE
                                                                                                 }
                                                                                          }
      #@ar_str.unshift(url)
      @ar_str.shift
      puts @ar_str.inspect
      #@ar_str.unshift(url)
      return @ar_str
    end

  end

end 
