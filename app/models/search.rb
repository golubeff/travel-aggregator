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
    self.date_from = Time.now.to_date.to_s(:db)
    self.date_till = (Time.now + 7.days).to_date.to_s(:db)
  end

  def results
    Teztour.search(self)
  end

end
