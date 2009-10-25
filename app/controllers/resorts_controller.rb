class ResortsController < ApplicationController

  def index
    @search = Resort.find_by_country_id(params[:country_id])
  end


end
