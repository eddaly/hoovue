class SearchController < ApplicationController
  def index
    @products = Product.findy_by_title(params[:search])
      @users = User.find_by_name(params[:search])
      
  end
end
