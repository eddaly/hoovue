class ApplicationController < ActionController::Base

 protect_from_forgery
  #Temp before filter for HTTP
   before_filter :authenticate
    before_filter :validation_count 

protected

#Temp Security Attr
  if RAILS_ENV= "development"
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "waterloo12"
                                              end
    end
 end
 
 #Cancan
 
   #Send to log in page if no auth   
      rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => "Please Log In"
    end

def validation_count 
  if current_user
  @credit_validations = CreditValidation.where(:user_id => current_user.id)
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
