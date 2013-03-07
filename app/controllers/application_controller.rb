class ApplicationController < ActionController::Base

 protect_from_forgery
  #Temp before filter for HTTP
   before_filter :authenticate
    before_filter :validation_count 
      before_filter :save_credit_params
        before_filter :update_credit_params
    
    def save_credit_params
      if params[:credit_id]
     session[:credit_id] = params[:credit_id]  
      end 
    end 
    
        def update_credit_params
          if session[:credit_id] && if current_user 
          @credit = Credit.find(session[:credit_id])  
          redirect_to @credit
            if current_user.email = @credit.pending_user_email
             @credit.user_id = current_user.id
              @credit.status = "confirmed"
              @credit.increment! :count
                  @credit.save
                    session.delete(:credit_id)
            end
                                   end
           end 
         end

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
      redirect_to root_url, :notice => "Not Authorized. Please Log In."
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
      redirect_to root_url, notice: "You not authorized for this action" if current_user.nil?
    end

    def admin_user
      @current_user.role == "admin"
    end  

end
