class FrontController < ApplicationController
  def index
    @credits = Credit.limit(10).order("created_at DESC")
      @products = Product.search(params[:search])
       @users_featured = User.where("id > ?", 5).limit(4).order("RANDOM()")
         @most_user_credits = User.limit(4).order("credits_count DESC")
            @most_product_credits = Product.limit(4).order("credits_count DESC")
     if current_user
        @credit_validations = CreditValidation.where(:validator_id => current_user.id).where(:status => "pending")
        @emails = Email.where(:user_id => current_user.id)
        @emails.each do |email|
          @unclamied_email_credits = Credit.where(:pending_user_email => email.email)
            end
          @unclaimed = Credit.where(:pending_user_email => current_user.email).where(:user_id => nil)
            @flagged_credits = CreditValidation.where(:user_id => current_user.id).where(:status => "pending").where(:credit_id => true)  
              @empty_credits = Credit.where(:user_id => current_user.id).limit(3)
        @credit_validation = CreditValidation.new
         @credit = Credit.new
     end
   end

def validate_new_email_credit
  @credit = Credit.find_by_id(params[:credit_id])
  @credit.pending_user_email = current_user.email
  @credit.user_id = current_user.id
  if @credit.save
    redirect_to root_url
  end
end   
   
end
