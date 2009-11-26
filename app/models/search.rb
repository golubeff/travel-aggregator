#require 'hpricot'
require 'open-uri'
require 'iconv'

class Search < ActiveRecord::Base

  belongs_to :country
  belongs_to :departure_city
  belongs_to :resort
  belongs_to :hotel_category
  belongs_to :meal
  belongs_to :accomodation

  def after_initialize
    self.date_from = (Time.now + 3.days).to_date.to_s(:db)
    self.date_till = (Time.now + 10.days).to_date.to_s(:db)
  end

  def results
    @ar_tez=Teztour.search(self).to_a
    @ar_pegas=Pegas.search(self).to_a
    @hash=  {
              'teztour'=>{'url'=>@ar_tez.shift,'data'=>@ar_tez},
              'pegas'=>{'url'=>@ar_pegas.shift,'data'=>@ar_pegas}
            }
    #print @hash.inspect
    return @hash
   
  end

end
