class HoldingController < ApplicationController
  def index
    @products = Product.limit(32)
  end
end
