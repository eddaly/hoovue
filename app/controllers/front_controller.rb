class FrontController < ApplicationController
  def index
    @credits = Credit.where(:user_id.blank? ).limit(10).order("created_at DESC")
     @products = Product.search(params[:search])
    
  end
end
