require 'hpricot'
require 'open-uri'
class Teztour

  OPERATOR_CODE = 'Teztour'

  class << self
    def url(search)
      args = [ ]

      if search.departure_city_id
        args << "cityId=#{search.departure_city.to_operator(OPERATOR_CODE)}"
      end

      date_from = search.date_from.to_date.to_s(:db).split('-').reverse.join('.')
      date_till = search.date_till.to_date.to_s(:db).split('-').reverse.join('.')
      args << "dateFromF=#{date_from}"
      args << "dateToF=#{date_till}"

      if search.hotel_category_id?
        args << "hotelTypeId=#{search.hotel_category.to_operator(OPERATOR_CODE)}"
        args << "hotelTypeBetter=on"
      end
      if search.meal_id?
        args << "pansionId=#{search.meal.to_operator(OPERATOR_CODE)}"
        args << "pansionBetter=on"
      end
      if search.accomodation_id?
        args << "hotelStayTypeId=#{search.accomodation.to_operator(OPERATOR_CODE)}"
      end

      args << "countryId=#{search.country.to_operator(OPERATOR_CODE)}"
      args << "tsChoosedCountryId=#{search.country.to_operator(OPERATOR_CODE)}"

      args << "childAge1=4"
      args << "childAge2=9"
      args << "tsChoosedRegionId=0"
      args << "sortColumn=price%3Basc"
      args << "showHotelStop=on"
      args << "showToFlightStop=on"
      args << "nightsFrom=7"
      args << "nightsTo=15"
      args << "priceFrom=0.0"
      args << "priceTo=15000"
      args << "template=print"
      args << "page=s%2Fpodbor"
      args << "tsId=Xert"
      args << "spoRegionSetId="
      args << "regionIdsSI="
      args << "showFromFlightStop=on"

      url = "http://book.teztour.com/book/actions/tourSearch.sdo?" + args.join('&')
      puts "url teztour: #{url}"
      return url
    end

    def search(search)

      # возвращаем пустой массив - если нет страны для этого оператора
      return [] if search.country.to_operator(OPERATOR_CODE).to_i == 0

      doc = open(self.url(search)) { |f| f.read }
      doc = Hpricot(Iconv.conv('utf-8', 'cp1251//IGNORE', doc.to_s))
      resultset = (doc/"tr.tsr1" | doc/"tr.tsr0").map do |tr|
        tds = tr/"td"
        next if tds.nil?

        {
          :date => (mdata = tds[1].inner_text.match(/(\d{2}\.\d{2}\.\d{2})(.+)/) and "#{mdata[1]}, #{mdata[2]}"),
          :nights => (mdata = tds[2].inner_text.match(/^(\d+)/) and mdata[1]),
          :region => (tds[4]/"font").inner_text,
          :hotel => (mdata = (tds[3]/"nobr").inner_text.match(/^(.+) [^ ]+ \*[^\*]+$/) and mdata[1]),
          :stars => (mdata = (tds[3]/"nobr").inner_text.match(/([^ ]+ \*)[^\*]+$/) and mdata[1]),
          :nomer => tds[6].inner_text.gsub(/\n/, ''),
          :eda => tds[5].inner_text.gsub(/\n/, ''),
          :coast => (tds[7]/"b").inner_text.sub(/^\$/, ''),
          :hotel_available => (tds[8].inner_text == 'ЕСТЬ'),
          :currency => 'USD',
          :operator => OPERATOR_CODE,
          :econom_out => self.determine_tickets(tds[9], tds[10]),
          :business_out => self.determine_tickets(tds[11], tds[12]),
          :econom_home => self.determine_tickets(tds[13], tds[14]),
          :business_home => self.determine_tickets(tds[15], tds[16])
        }
      end

      return resultset
    end

    def determine_tickets(*tds)
      return 'Y' if tds.flatten.any? { |i| i.inner_text != 'Нет' }
      return 'N'
    end

    
  end

end 
