class FrontController < ApplicationController
  def index
    @credits = Credit.confirmed.where(:user_id.blank? ).limit(10).order("created_at DESC")
     @products = Product.search(params[:search])
      @products_featured = Product.limit(3).order("RANDOM()")
    
  end
end
