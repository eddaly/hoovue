class FrontController < ApplicationController
  def index
    @credits = Credit.limit(10)
     @products = Product.search(params[:search])
  end
end
