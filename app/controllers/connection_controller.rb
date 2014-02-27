class ConnectionController < ApplicationController
  
  def index
    if @current_user
      if params[:name]
        @users = User.where(:name => params[:name]).where("credits_count > ?", 0)
      else
        @users = User.where(:name => @current_user.name).where("credits_count > ?", 0)
      
  end
    else
    redirect_to root_url
  end
  end
  
end
