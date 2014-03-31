class FrontController < ApplicationController
  def index
    @credits = Credit.limit(10).order("created_at DESC")
       @users_featured = User.find_all_by_id([13, 19, 3, 12])
         @most_user_credits = User.limit(4).order("credits_count DESC")
            @most_product_credits = Product.limit(4).order("credits_count DESC")
     if current_user
        @credit_validations = CreditValidation.where(:validator_id => current_user.id).where(:status => "pending")
        @emails = Email.where(:user_id => current_user.id)
        @emails.each do |email|
          @unclamied_email_credits = Credit.where(:pending_user_email => email.email)
            end
            
            @related_credits = Credit.where(:user_id => current_user.id)
              @related_credits.each do |rc|
              @studio = rc.product.studio
                @products = Product.where(:studio => @studio)
                @products.each do |p|
                  @related_products = Product.where(:studio => @studio)
                end
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
  @credit.confirmed_validations_count = @credit.credit_validations.confirmed.count
  @credit.user_id = current_user.id
  if @credit.save
    redirect_to root_url
  end
end   


def stats
  if current_user.googleplus == "lecrabe"
    @users = User.order(:updated_at)
    @cv = CreditValidation.all
  @users_total = User.all.size
  @users_with_credits = User.where("credits_count > ?", 0).size
  @users_with_credits_percentage = @users_with_credits * 100 / @users_total
  @users_last_day = User.where("created_at > ?", 24.hours.ago).size
  @users_last_week = User.where("created_at > ?", 1.week.ago).size
  @users_last_month = User.where("created_at > ?", 1.month.ago).size
  
  @users_with_facebook = User.where(:provider => "facebook").size
  @users_with_facebook_percentage = @users_with_facebook * 100 / @users_total
  @users_with_bio = User.where(:bio => nil).size
  @users_with_bio_percentage = @users_with_bio - @users_total * 100 / @users_total

  
  @credits_total = Credit.all.size
  @credits_with_verifiers = Credit.where("credit_validation_count > ?", 0).size
  @credits_with_verifiers_percentage = @credits_with_verifiers * 100 / @credits_total  
  @credits_last_day = Credit.where("created_at > ?", 24.hours.ago).size
  @credits_last_week = Credit.where("created_at > ?", 1.week.ago).size
  @credits_last_month = Credit.where("created_at > ?", 1.month.ago).size

  
  @cv_total = CreditValidation.all.size
  @cv_confirmed = CreditValidation.where(:status => "confirmed").size
  @cv_percentage = @cv_confirmed * 100 / @cv_total
  @credits_v_last_day = CreditValidation.where("created_at > ?", 24.hours.ago).size
  @credits_v_last_week = CreditValidation.where("created_at > ?", 1.week.ago).size
  @credits_v_last_month = CreditValidation.where("created_at > ?", 1.month.ago).size
else
  redirect_to root_url
end
end 

def suggested
  @product = Product.find_by_id(params[:product_id])
  @suggested = Product.where(:studio => @product.studio).limit(4)
  if @suggested.empty?
    redirect_to product_path(@product)
  end
end
  
end
