class UsersController < ApplicationController
 
 load_and_authorize_resource
  skip_authorize_resource :only => :new

def index 
  redirect_to root_url
end

def new
  @user = User.new
end


def create
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
        redirect_to root_url, notice: "Thank you for signing up!"
  else
    render "new"
  end
end

def show
  @user = User.find(params[:id])

if current_user && current_user.id == @user.id 
  @match = "t"
end

  @user_page = User.find(params[:id])
    @credits = @user.credits.includes(:credit_validations).includes(:posts).includes(:product).includes(:user).order("promoted, confirmed_validations_count DESC, credit_validation_count DESC, updated_at DESC")
 	 @credits_red = Credit.order_by_rand.limit(20).all
 
          @credit_validation = CreditValidation.new
            @credit = Credit.new
            @post = Post.new
            @verified_credits = @credits.cv_confirmed.count
            @part_verified_credits = @credits.cv_part.count
            @pending_credits = @credits.length - @verified_credits.to_i + @part_verified_credit.to_i
            @user_credits_count = @pending_credits + @verified_credits + @part_verified_credits
            
end

def edit
 # if current_user.id == @user.id
  @user = User.find(params[:id])
    @emails = Email.where(:user_id => current_user.id)
    #else
#    redirect_to root_url
#  end
end

def update
  @user = User.find(params[:id])
  respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { redirect_to @user, notice: 'Your profile has been updated.' }
    else
      format.html { render action: "edit" }
    end
  end
end

end
