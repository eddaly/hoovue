class HoldingController < ApplicationController
  def index
    @products = Product.all
  end
end
