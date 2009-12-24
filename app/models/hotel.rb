require 'open-uri'
require 'hpricot'
require 'cgi'

class Hotel
  class << self
    def find_by_title(title)

      url = "http://www.google.com/search?q=#{CGI.escape('"' + title.to_s + '"')}+inurl%3Awww.tophotels.ru/main/hotel/+-inurl:tours"
      puts url
      doc = Hpricot(open(url))
      return ((doc/"h3.r").first/"a.l").first['href']
    rescue
      return nil
    end
  end
end
