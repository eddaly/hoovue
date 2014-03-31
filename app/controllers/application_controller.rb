class ApplicationController < ActionController::Base
 protect_from_forgery

  
    before_filter :validation_count 
      before_filter :update_credit_params
        before_filter :update_facebook_params
            before_filter :save_credit_params
              before_filter :save_facebook_params
              before_filter :pending_cv
       
        def beta_user
          @beta_user ||= Betauser.find(session[:beta_user_id]) if session[:beta_user_id]
        end
    
        def authorize_beta
          redirect_to new_betasession_path, notice: "whoactually.com is under development please log in." if beta_user.nil?
        end
   
    def save_credit_params
      if params[:credit_id]
     session[:credit_id] = params[:credit_id]  
     end 
    end 
    
    def save_facebook_params
      if params[:pending_token]
        if @credit.nil?
          redirect_to root_url, :notice => "Please sign in."
          session.delete(:pending_token)
        end  
     session[:pending_token] = params[:pending_token]  
     end 
    end
    
    def update_facebook_params
      begin
        
        #Check if link params are true
        
      if session[:pending_token] && if current_user
        @credit = Credit.find_by_pending_token(session[:pending_token])
        
        #Update params 
        
          @credit.user_id = current_user.id
          @credit.user_name = current_user.name
          
          #Find validators CV and update
          
        @credit_validation = CreditValidation.find_by_id(@credit.credit_validation_id)
          @credit_validation.validator_id = current_user.id
          @credit_validation.status = "confirmed"
          @credit_validation.save
          @credit_validator = Credit.find_by_id(@credit_validation.credit_id)
          @credit.confirmed_validations_count = @credit.credit_validations.confirmed.count
          @credit_validator.save
        if @credit.save
          
          #Create new CV for use and set as conf with id from validator
          
         @credit_validation = CreditValidation.new(params[:credit_validation])
          @credit_validation.validator_id = @credit.validator_id
          @credit_validation.credit_id = @credit.id
          @credit_validation.status = "confirmed"
          @credit_validation.user_id = current_user.id
           @credit_validator = Credit.find_by_id(@credit_validation.credit_id)
            if @credit_validation.save
             
              #Reset count on users C
          
                 
                  @credit_validator.confirmed_validations_count = @credit_validator.credit_validations.confirmed.count
                  @credit_validator.save
                  
                  #Finish and redirect
               
                redirect_to root_url, :notice => "Your Facebook refered credit has been added."
                session.delete(:pending_token)
        end
          end
        end
      end  
    rescue Exception
      session.delete(:pending_token)
      session.delete(:credit_id)
      redirect_to root_url
    end
    
    end
    
def update_credit_params
    if session[:credit_id] && if current_user 
      
      #Find linked credit and update prams
      
      @credit = Credit.find(session[:credit_id])  
        if @credit.pending_user_email == current_user.email
          redirect_to @credit
          @credit.user_id = current_user.id
          @credit.user_name = current_user.name
          
        #Find validators CV and update status  
          
          @credit_validation = CreditValidation.find_by_id(@credit.credit_validation_id)
            if @credit_validation
              @credit_validation.status = "confirmed"
              @credit_validation.validator_id = current_user.id
              @credit_validation.update_attributes(params[:credit_validationn])
              
              #Update validators C CV conf count
              
              @credit_validator = Credit.find_by_id(@credit_validation.credit_id)
              @credit_validator.confirmed_validations_count = @credit_validator.credit_validations.confirmed.count
                @credit_validator.save
            else
            end
            
            #Make new CV for new C and make status conf from validator
            
            @credit_validation = CreditValidation.new(params[:credit_validation])
               @credit_validation.user_id = current_user.id
               @credit_validation.validator_id = @credit.validator_id
               @credit_validation.status = "confirmed"
                 if  @credit.save
                       @credit_validation.credit_id = @credit.id
                       if  @credit_validation.save
                         @credit.confirmed_validations_count = @credit.credit_validations.confirmed.count
                         @credit.save
                        session.delete(:credit_id) #Remove credit
                      end
                end
                  
                else
                  redirect_to root_url, :notice => "The email that got you here isn't associated with your profile.  But you can add it <a href=/emails/new>here.</a>".html_safe
                    session.delete(:credit_id)     
                  end
              end
              end 
end
         
         def current_user
           @current_user ||= User.find(session[:user_id]) if session[:user_id]
         end 
         
         def pending_cv
           if current_user
           @pending_cv = CreditValidation.where(:user_id => current_user.id).where(:status => "pending").where(:oneside => "true")
         end
          end   

protected

 
 #Cancan
 
   #Send to log in page if no auth   
      rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :notice => "Please sign in."
    end

def validation_count 
  if current_user
  @credit_validations = CreditValidation.where(:user_id => current_user.id)
  end
end



private



  helper_method :current_user

    def authorize
      redirect_to root_url, notice: "You are not authorized for this action" if current_user.nil?
    end

    def admin_user
      @current_user.role == "admin"
    end  

end
