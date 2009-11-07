# To change this template, choose Tools | Templates
# and open the template in the editor.

class Pegas

  OPERATOR_CODE = 'Pegas'

  class << self
    def search(search)
      date_from=search.date_from.to_date.to_s(:db).gsub("-","")

      date_till=search.date_till.to_date.to_s(:db).gsub("-","")
      t_now=Time.now.to_i
      url = "http://pegast.ru/samo5/search_tour?samo_action=PRICES&STATEINC=#{search.country.to_operator(OPERATOR_CODE)}&TOWNFROMINC=2&TOURINC=3&CURRENCY=1&NIGHTS_FROM=7&NIGHTS_TILL=14&ADULT=2&CHECKIN_BEG=#{date_from}&CHECKIN_END=#{date_till}&AGES=&PACKET=0&PRICEPAGE=1&_=#{t_now}"
      #парсин пегас пока из файла, потом надо будет сделать загрузку из url
      #url = 'http://localhost:3000/pegas_answer_clear.html';

      puts 'pegas url: '

      puts url

      doc = open(url) { |f| f.read }
      

        
        doc=doc.to_s.sub!(/^.*<tbody>/m, "")
        doc=doc.to_s.gsub!(/\\/mi, "")
        doc=doc.to_s.sub!(/<\/script>.*$/m,"")
        puts "result = :"
        puts doc

        
        

    end

  end

end
