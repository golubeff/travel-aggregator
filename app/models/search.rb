require 'hpricot'
require 'open-uri'

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
    Teztour.search(self)
    Pegas.search(self)

    #tz.to_s << pg.to_s
  end

end
