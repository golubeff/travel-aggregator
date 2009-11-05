class ResortsController < ApplicationController

  def index
    puts "country_id: "
    puts params[:country_id]
    @resorts = Resort.find(:all,:conditions=>"country_id = '#{params[:country_id]}'")
    puts "resorts: #{@resorts}"
    @resorts.each  do |res|
      puts "title - #{res.title}"
    end
    @resorts
  end


end
