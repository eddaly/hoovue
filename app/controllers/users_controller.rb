class UsersController < ApplicationController

def index 
  @users = User.all
end

def new
  @user = User.new
end


def create
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
      UserMailer.signup_confirmation(@user).deliver
        redirect_to root_url, notice: "Thank you for signing up!"
    
  else
    render "new"
  end
end

def show
  @user = User.find(params[:id])
    @credits = @user.credits.where(:product.nil?)
      @posts = @user.posts.all
        @credit_validations = CreditValidation.where(:user_id => @user.id)
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { redirect_to @user, notice: 'Your Profile has been updated.' }
    else
      format.html { render action: "edit" }
    end
  end
end

end
