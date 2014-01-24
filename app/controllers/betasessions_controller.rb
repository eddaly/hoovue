class BetasessionsController < ApplicationController
 
 skip_before_filter :authorize_beta
 
  def new
    end

    def create
      betauser = Betauser.find_by_email(params[:email])
        if betauser && betauser.authenticate(params[:password])
          session[:beta_user_id] = betauser.id
          redirect_to root_url, :notice => "Logged in!"
        else
          flash.now.alert = "Invalid email or password"
          render "new"
        end
    end

    def destroy
      session[:beta_user_id] = nil
      redirect_to root_url, :notice => "Logged out!"
    end
end
