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
  @credits = Credit.where(:developer_id == @current_user.developer_id)
  @user_page = User.find(params[:id])
    @credits = @user.credits.order("promoted DESC, updated_at DESC")
      @posts = @user.posts.all
        @credit_validations = CreditValidation.where(:user_id => @user.id)
          @credit_validation = CreditValidation.new
            @credit = Credit.new
            @post = Post.new
            @followers = Friendship.where(:friend_id => @user.id)
             @verified_credits = @user.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "3")
             @one_verified_credits = @user.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "1")
             @two_verified_credits = @user.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "2")
             @part_verified_credits = @one_verified_credits.count + @two_verified_credits.count 
             @pending_credits = @user.credits.includes(:credit_validations).where("credit_validations.status = 'pending'")
            
end

def edit
  if current_user.id == @user.id
  @user = User.find(params[:id])
    @emails = Email.where(:user_id => current_user.id)
  else
    redirect_to root_url
  end
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
