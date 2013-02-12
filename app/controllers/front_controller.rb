class FrontController < ApplicationController
  def index
    @credits = Credit.limit(10).order("created_at DESC")
     @products = Product.search(params[:search])
  end
end
