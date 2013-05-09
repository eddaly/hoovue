class ApplicationController < ActionController::Base
 protect_from_forgery

  
    before_filter :validation_count 
      before_filter :update_credit_params
        before_filter :update_facebook_params
          before_filter :authorize_beta
            before_filter :save_credit_params
              before_filter :save_facebook_params
       
        def beta_user
          @beta_user ||= Betauser.find(session[:beta_user_id]) if session[:beta_user_id]
        end
    
        def authorize_beta
          redirect_to new_betasession_path, notice: "hoovue.com is under development please log in." if beta_user.nil?
        end
   
    def save_credit_params
      if params[:credit_id]
     session[:credit_id] = params[:credit_id]  
     end 
    end 
    
    def save_facebook_params
      if params[:pending_token]
     session[:pending_token] = params[:pending_token]  
     end 
    end
    
    def update_facebook_params
      if session[:pending_token] && if current_user
        @credit = Credit.find_by_pending_token(session[:pending_token])
        @credit.user_id = current_user.id
        @credit.user_name = current_user.name
        if @credit.save
         @credit_validation = CreditValidation.new(params[:credit_validation])
          @credit_validation.validator_id = @credit.validator_id
          @credit_validation.credit_id = @credit.id
          @credit_validation.status = "confirmed"
          @credit_validation.user_id = current_user.id
          if @credit_validation.save
          redirect_to root_url, :notice => "Your Facebook refered credit has been added."
          session.delete(:pending_token)
        end
          end
        end
      end  
    end
    
        def update_credit_params
          if session[:credit_id] && if current_user 
          @credit = Credit.find(session[:credit_id])  
            if @credit.pending_user_email == current_user.email
               redirect_to @credit
             @credit.user_id = current_user.id
             @credit.user_name = current_user.name
             @credit_validation = CreditValidation.find_by_id(@credit.credit_validation_id)
             @credit_validation.status = "confirmed"
             @credit_validation.validator_id = current_user.id
             @credit_validation.update_attributes(params[:credit_validationn])
             @credit_validation = CreditValidation.new(params[:credit_validation])
               @credit_validation.user_id = current_user.id
               
               @credit_validation.validator_id = @credit.validator_id
               @credit_validation.status = "confirmed"
               if  @credit.save
                 @credit_validation.credit_id = @credit.id
                   @credit_validation.save
                    session.delete(:credit_id)
                  end
                  
                else
                  redirect_to root_url, :notice => "You email does not match the credit. Are you signed in with the right account?"
                    session.delete(:credit_id)     
            end
          end
           end 
         end
         
       

protected

 
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
