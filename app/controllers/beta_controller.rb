class BetaController < ApplicationController
  def index
    @featured_users = User.find_all_by_id([13, 3, 19,121,15])
    @users = User.where(:profile_picture.blank?).where("credits_count > ?", 0).where(:provider => "facebook").order("RANDOM()").limit(45)
    @works = Product.limit(80).where("credits_count > ?", 0).where(:image.blank?).order("RANDOM()")
       @popular_works = Product.limit(8).order("RANDOM()")
       @recent_credits = Credit.limit(8).order("RANDOM()")
       if current_user
         
          @credit_validations = CreditValidation.where(:validator_id => current_user.id).where(:status => "pending")
          @emails = Email.where(:user_id => current_user.id)
        
            @unclamied_email_credits = Credit.where(:pending_user_email => current_user.email).where(:user_id.nil?)
            
               end
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
