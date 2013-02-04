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
    redirect_to root_url, notice: "Thank you for signing up!"
  else
    render "new"
  end
end

def show
  @user = User.find(params[:id])
   @credits = @user.credits.all
    @posts = @user.posts.all
    @credit_validations = CreditValidation.where(:user_id => @user.id)
end

end
