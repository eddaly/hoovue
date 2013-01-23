class HoldingController < ApplicationController
   def index
    @products = Product.search(params[:search])

    respond_to do |format|
      format .js
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end
end
