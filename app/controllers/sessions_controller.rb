class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if current_user.credits_count < 1
    redirect_to connection_index_path(name: current_user.name), notice: "Thank you for signing up!"
  else
    redirect_to root_url, notice: "Welcome Back"
  end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end