class ConnectionController < ApplicationController
  
  def index
    @user = User.where(:name => @current_user.name).where("credits_count > ?", 0).last
    
  end
  
end
