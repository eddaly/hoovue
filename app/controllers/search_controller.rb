class SearchController < ApplicationController
  def index
    @products = Product.search(params[:search])
      @users = User.search(params[:search])
      
  end
end
