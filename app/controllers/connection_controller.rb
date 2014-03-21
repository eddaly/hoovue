class ConnectionController < ApplicationController
  
  def index
    if @current_user
      if params[:name]
        @users = User.where(:name => params[:name]).where("developer_id > ?", 1) 
 
      else
        @users = User.where(:name => @current_user.name).where("developer_id > ?", 1) 
 
  end
    else
      @users = User.where(:name => params[:name]).where("developer_id > ?", 1) 
 
  end
  end
  
end
