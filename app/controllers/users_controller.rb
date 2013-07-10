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
    @credits = @user.credits.order("credit_validations_count DESC")
      @posts = @user.posts.all
        @credit_validations = CreditValidation.where(:user_id => @user.id)
          @credit_validation = CreditValidation.new
            @credit = Credit.new
            @post = Post.new
            @followers = Friendship.where(:friend_id => @user.id)
end

def edit
  @user = User.find(params[:id])
    @emails = Email.where(:user_id => current_user.id)
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
