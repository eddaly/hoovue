class CreditsController < ApplicationController
  
  
  load_and_authorize_resource
  
  # GET /credits
  # GET /credits.json
  def index
    @credits = Credit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credits }
    end
  end
  
  def import
  Credit.import(params[:file])
  redirect_to root_url, notice: "credits imported."
end

  # GET /credits/1
  # GET /credits/1.json
  def show
    @credit = Credit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit }
    end
  end

  # GET /credits/new
  # GET /credits/new.json
  def new
    @credit = Credit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit }
    end
  end

  # GET /credits/1/edit
  def edit
      session[:return_to] = request.referer
        @credit = Credit.find(params[:id])
         
  end
  
  def role
      session[:return_to] = request.referer
    @credit = Credit.find(params[:id])
    1.times do
        credit_validation = @credit.credit_validations.where(:user_id => current_user.id)
   end   
  end
  
  def search
    @products = Product.search(params[:search])
    if current_user
      @credit = Credit.new
    end  
  end

  def flag
    @credit = Credit.find(params[:id])
    @credit_validation = CreditValidation.find_by_id(@credit.credit_validation_id)
      @credit_validation.status = "pending"
        @credit_validation.save
      flash[:notice] = "Thank you we will look into it."
      redirect_to root_url
  end
  
  def batch
    @credit = Credit.new
   
   
  end
  

  # POST /credits
  # POST /credits.json
  def create 
    @credit = Credit.new(params[:credit])
     if params[:batch]
     @credit.role = params[:role]
     @credit.product_id = params[:product_id]
     @credit.user_id = current_user.id
   end
     @credit.pending_token = SecureRandom.urlsafe_base64(20)
    if @credit.pending_user_email == current_user.email
      redirect_to :back, notice: 'You cannot validate yourself.'
    else
      if params[:facebook]
         @credit.validator_id = current_user.id
      else
     
     end
        @credit_validation = CreditValidation.new(params[:credit_validation])
        @credit_validation.status = "pending"
          @credit.validator_id = current_user.id
          @credit_validation.user_id = current_user.id
            @credit_validation.credit_id = @credit.current_credit_id
      respond_to do |format|
      if @credit.save
        if  @credit_validation.save
             @credit.credit_validation_id = @credit_validation.id
              @credit.user_name = current_user.name
           @credit.update_attributes(params[:credit])
         else
          
         end
        if @credit.pending_user_email
        CreditMailer.new_credit(@credit).deliver
        end
        if params[:batch]
          format.html { redirect_to :back, notice: 'Credit was successfully created.' }
        end 
        
        if params[:facebook]
          format.html { redirect_to ("https://www.facebook.com/dialog/send?app_id=#{ENV['FACEBOOK_APP_ID']}&
name=whoactually.com%20credit%20-%20Get%20the%20recognition%20you%20deserve&description=As%20a%20co-creator%20on%20#{@credit.product.title},%20#{current_user.name}%20would%20like%20you%20to%20validate%20their%20credit.%20#{current_user.name}%20also%20recorded%20that%20you%20were%20#{@credit.role}.%20To%20validate%20this%20credit%20and%20claim%20your%20own%20follow%20this%20link.&link=http://#{ENV['DEFAULT_URL']}/credits/#{@credit.id}?pending_token=#{@credit.pending_token}&
redirect_uri=http://#{ENV['DEFAULT_URL']}")}
        end 
         
        format.html { redirect_to product_path(@credit.product_id), notice: 'Credit was successfully created.' }
   
        format.json { render json: @credit, status: :created, location: @credit }
      else
        flash[:error] =  @credit.errors.full_messages.each do |msg| msg.gsub(/\W+/, '')  end 
        format.html { redirect_to :back }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PUT /credits/1
  # PUT /credits/1.json
  def update
    @credit = Credit.find(params[:id])
     
    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to session[:return_to], notice: 'Your Credit has been updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.json
  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Credit deleted' }
      format.json { head :no_content }
    end
  end
end
