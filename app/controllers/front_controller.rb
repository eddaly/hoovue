class FrontController < ApplicationController
  def index
    @credits = Credit.confirmed.where(:user_id.blank? ).limit(10).order("created_at DESC")
    @products = Product.search(params[:search])
     @users_featured = User.limit(4).order("RANDOM()")
     if current_user
      @credit_validations = CreditValidation.where(:validator_id => current_user.id).where(:status => "pending")
      @unclaimed = Credit.where(:pending_user_email => current_user.email).where(:user_id => nil)
       @flagged_credits = CreditValidation.where(:user_id => current_user.id).where(:status => "pending").where(:credit_id => true)  
       @empty_credits = Credit.where(:user_id => current_user.id).limit(3)
       @credit = Credit.new
     end
   end
end