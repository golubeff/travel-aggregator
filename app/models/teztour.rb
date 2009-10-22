class Teztour

  OPERATOR_CODE = 'Teztour'

  class << self
    def search(search)
      url = 'http://book.teztour.com/book/actions/tourSearch.sdo?template=print&page=s%2Fpodbor&tsId=Xert'
      url << "&countryId=#{search.country.to_operator(OPERATOR_CODE)}"
      url << "&cityId=#{search.departure_city.to_operator(OPERATOR_CODE)}"
      url << "&dateFromF=#{search.date_from}"
      url << "&dateToF=#{search.date_till}"
      url << "&hotelTypeId=#{search.hotel_category.to_operator(OPERATOR_CODE)}"
      url << "&sortColumn=price%3Basc"
      doc = open(url) { |f| Hpricot(f) }

      (doc.search("//tr[@class='tsr0']") | doc.search("//tr[@class='tsr1']")).map do |tour|
        attributes = tour.search("td")

        hotel = attributes[3]
        hotel.innerText
      end
    end
  end

end 
