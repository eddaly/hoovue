class HoldingController < ApplicationController
  def index
    @products = Product.limit(10)
  end
end
