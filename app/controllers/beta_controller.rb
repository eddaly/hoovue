class BetaController < ApplicationController
  def index
    @featured_users = User.find_all_by_id([13, 3, 19,121,15])
    @users = User.where(:profile_picture.blank?).where("credits_count > ?", 0).where(:provider => "facebook").order("RANDOM()").limit(45)
    @works = Product.limit(80).where("credits_count > ?", 0).where(:image.blank?).order("RANDOM()")
  #  @recent_credits = Credit.limit(8).order("RANDOM()")
   
       #Random Popular works
       
       offset_1 = rand(Product.count)
       @pw_1 = Product.first(:offset => offset_1)
       
       offset_2 = rand(Product.count)
       @pw_2 = Product.first(:offset => offset_2)
       
       
       offset_3 = rand(Product.count)
       @pw_3 = Product.first(:offset => offset_3)
       
       
       offset_4 = rand(Product.count)
       @pw_4 = Product.first(:offset => offset_4)
       
       
       offset_5 = rand(Product.count)
       @pw_5 = Product.first(:offset => offset_5)
       
         
          #Random Credits
          
       
          offset_c_1 = rand(Credit.count)
          @c_1 = Credit.first(:offset => offset_1)
       
          offset_c_2 = rand(Credit.count)
          @c_2 = Credit.first(:offset => offset_2)
       
       
          offset_c_3 = rand(Credit.count)
          @c_3 = Credit.first(:offset => offset_3)
       
          offset_c_4 = rand(Credit.count)
          @c_4 = Credit.first(:offset => offset_4)
       
       
          offset_c_5 = rand(Credit.count)
          @c_5 = Credit.first(:offset => offset_5)
       
       
       
       
       if current_user
         
          @credit_validations = CreditValidation.where(:validator_id => current_user.id).where(:status => "pending")
          @emails = Email.where(:user_id => current_user.id)
        #  @pending_cv = CreditValidation.where(:user_id => current_user.id).where(:oneside => "true")
            @unclamied_email_credits = Credit.where(:pending_user_email => current_user.email).where(:user_id => nil)
            
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
