# To change this template, choose Tools | Templates
# and open the template in the editor.

class Pegas

  OPERATOR_CODE = 'Pegas'

  class << self
    def search(search)
      date_from=search.date_from.to_date.to_s(:db).gsub("-","")

      date_till=search.date_till.to_date.to_s(:db).gsub("-","")
      t_now=Time.now.to_i
      #samo_action=PRICES& - запрашивае прайс
      #STATEINC=#{search.country.to_operator(OPERATOR_CODE)}& - запрашиваем страну для тура
      #TOWNFROMINC=2& - откуда летим - по умолчанию пока москва
      #TOURINC=& - что за туристическая зона в стране (специфично для каждой страны)
      #CURRENCY=1& - валюта (1 - рубли)
      #NIGHTS_FROM=7& - искать туры, чтобы ночей было от
      #NIGHTS_TILL=14& - ночей до
      #ADULT=2& - сколько взрослых едет (по умолчанию Double)
      #CHECKIN_BEG=#{date_from}& - дата начала тура (вылета)
      #CHECKIN_END=#{date_till}& - граница даты начала (вылета)
      #AGES=& - возраст ребенка - если есть
      #PACKET=0& - х.з.
      #PRICEPAGE=1& - показывать страницу - по умолчанию первую
      #_=#{t_now}" - чтобы запрос не кешировался
      url = "http://pegast.ru/samo5/search_tour?"
      url << "samo_action=PRICES&STATEINC=#{search.country.to_operator(OPERATOR_CODE)}"
      if search.meal_id?
        url << "&MEAL=#{search.meal.to_operator(OPERATOR_CODE)}"
      end
      if search.hotel_category_id?
        url << "&STARS=#{search.hotel_category.to_operator(OPERATOR_CODE)}"
      end
      if search.departure_city_id
        url << "&TOWNFROMINC=#{search.departure_city.to_operator(OPERATOR_CODE)}"
      end
      url << "&TOURINC=&CURRENCY=2&NIGHTS_FROM=7&NIGHTS_TILL=14"
      if search.accomodation_id?
      url << "&ADULT=#{search.accomodation.to_operator(OPERATOR_CODE)}"
      end
      url << "&CHECKIN_BEG=#{date_from}&CHECKIN_END=#{date_till}&AGES=&PACKET=0&PRICEPAGE=1&_=#{t_now}"
      #парсин пегас пока из файла, потом надо будет сделать загрузку из url
      #url = 'http://localhost:3000/pegas_answer_clear.html';

      #puts 'pegas url: '
      #puts url

      @ar_str=()
      # возвращаем пустой массив - если нет страны для этого оператора
      if search.country.to_operator(OPERATOR_CODE).to_i == 0
        return @ar_str
      end
      doc = open(url) { |f| f.read }
      doc=Iconv.conv('utf-8', 'cp1251//IGNORE',  doc.to_s)
      
        doc.to_s.sub!(/^.*<\/th><\/tr>/m, "")
        doc.to_s.sub!(/^.*<\/thead><tbody>/m, "")

        doc.to_s.gsub!(/\\/mi, "")
        doc.to_s.gsub!(/<td([^>]+){0,1}>/mi, "")
        doc.to_s.gsub!(/<tr([^>]+){0,1}>/mi, "")
        doc.to_s.sub!(/<\/tbody><\/table>.*$/m,"")


        puts doc.inspect

        @ar_str=doc.to_s.split('</td></tr>').map { |item| item.to_s.split('</td>') }.map { |it| {'date'=>it[0],
                                                                                                 'region'=>it[1],
                                                                                                 'nights'=>it[2],
                                                                                                 'hotel'=>"#{it[3]}".sub(/(\d{1}\*\+{0,1})/i,''),
                                                                                                 'stars'=>$1,
                                                                                                 'bron_link'=>"#{it[3]}".sub(/<a href="([^"]+)".*$/i,'').to_s + $1.to_s,
                                                                                                 'eda'=>it[4],
                                                                                                 'nomer'=>"#{it[5]}".sub(/\/(\w+)$/,''),
                                                                                                 'nomer_col_type'=> $1,
                                                                                                 'coast'=>"#{it[6]}".sub(/\s+([A-Z]+)$/i, ''),
                                                                                                 'currency'=> $1,
                                                                                                 'coast_spo'=>it[7],
                                                                                                 'type_of_coast'=>it[7],
                                                                                                 'econom'=>it[8],
                                                                                                 'business'=>it[9],
                                                                                                 'operator'=>OPERATOR_CODE
                                                                                                 }
                                                                                          }

      if @ar_str[0]['date'].to_s.scan(/<script/).size>0
        @ar_str=()
        return @ar_str
      end
      
        #print @ar_str.inspect
        return @ar_str


    end

  end

end
