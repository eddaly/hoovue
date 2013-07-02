class BetaController < ApplicationController
  def index
    @featured_users = User.find_all_by_id([13, 19, 3, 12,13,15])
       @popular_works = Product.limit(8).order("credits_count DESC")
       @recent_credits = Credit.limit(12).order("created_at DESC")
  end

  def work
    @product = Product.find_by_id(79)
    @credits = Credit.where(:product_id => @product.id).where(:user_id != nil)
  end

  def user
  end
end
