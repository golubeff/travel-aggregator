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
      url = "http://pegast.ru/samo5/search_tour?samo_action=PRICES&STATEINC=#{search.country.to_operator(OPERATOR_CODE)}&TOWNFROMINC=2&TOURINC=&CURRENCY=1&NIGHTS_FROM=7&NIGHTS_TILL=14&ADULT=2&CHECKIN_BEG=#{date_from}&CHECKIN_END=#{date_till}&AGES=&PACKET=0&PRICEPAGE=1&_=#{t_now}"
      #парсин пегас пока из файла, потом надо будет сделать загрузку из url
      #url = 'http://localhost:3000/pegas_answer_clear.html';

      puts 'pegas url: '

      puts url

      doc = open(url) { |f| f.read }
      
        @ar_str=(0)
        doc.to_s.sub!(/^.*<\/th><\/tr>/m, "")
        doc.to_s.gsub!(/\\/mi, "")
        doc.to_s.gsub!(/<td([^>]+){0,1}>/mi, "")
        doc.to_s.gsub!(/<tr([^>]+){0,1}>/mi, "")
        doc.to_s.sub!(/<\/tbody><\/table>.*$/m,"")
        #print doc.to_s
        @ar_str=doc.to_s.split('</td></tr>').map { |item| item.to_s.split('</td>') }
        return @ar_str
        #print @ar_str.size

        #print @ar_str.inspect

    end

  end

end
