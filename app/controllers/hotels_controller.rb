class HotelsController < ApplicationController
  def show
    redirect_to Hotel.find_by_title(params[:id]) || '/404.html'
  end
end
