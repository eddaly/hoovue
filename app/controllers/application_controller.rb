class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

protected

#Temp Security Attr
  if RAILS_ENV= "development"
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "waterloo12"
                                              end
    end
 end
 
 private

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
helper_method :current_user

def authorize
  redirect_to login_url, alert: "Not authorized" if current_user.nil?
end


end
