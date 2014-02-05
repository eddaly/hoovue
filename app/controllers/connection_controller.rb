class ConnectionController < ApplicationController
  
  def index
    if @current_user
    @users = User.where(:name => @current_user.name).where("credits_count > ?", 0)
    else
    redirect_to root_url
  end
  end
  
end
