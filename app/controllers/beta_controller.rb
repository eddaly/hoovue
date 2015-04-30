class BetaController < ApplicationController

  helper :all

  def index
    @featured_products = Product.where(title: ["Grand Theft Auto V", "Battlefield 4",  "Call of Duty: Black Ops"]).order("title")
    @popular_products = Product.most_popular
    @recent_products = Product.most_recents
    @recent_credits = Credit.most_recents
  end

  def work
    @product = Product.find_by_id(79)
    @credits = Credit.find_all_by_id([101,20,102])
    @credit = Credit.new
    @credit_validation = CreditValidation.new
    @post = Post.new
  end

  def user
    @user = User.find_by_id(2)
    @credits = Credit.where(:user_id => 2)

  end
end
