class CreditValidationsController < ApplicationController
  # GET /credit_validations
  # GET /credit_validations.json
  def index
    @credit_validations = CreditValidation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credit_validations }
    end
  end

  # GET /credit_validations/1
  # GET /credit_validations/1.json
  def show
    @credit_validation = CreditValidation.find(params[:id])
    @validator = User.find_by_id(@credit_validation.validator_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit_validation }
    end
  end
  
  def validate
     @credit_validation = CreditValidation.find(params[:id])
     @credit_validation.status = "confirmed"
          if @credit_validation.update_attributes(params[:credit_validation])
           
          flash[:notice] = "Thank you for validating"
          redirect_to :back
        end
  end
  
  def flag
     @credit_validation = CreditValidation.find(params[:id])
     @credit_validation.status = "pending"
          if @credit_validation.update_attributes(params[:credit_validation])
          flash[:notice] = "Credit Flagged"
          redirect_to :back
        end
  end

  # GET /credit_validations/new
  # GET /credit_validations/new.json
  def new
    @credit_validation = CreditValidation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit_validation }
    end
  end

  # GET /credit_validations/1/edit
  def edit
    @credit_validation = CreditValidation.find(params[:id])
  end
  
  def validation
    @credit_validation = CreditValidation.new
    if @credit_validation.save
       flash[:notice] = "Credit Validated."
    end
  end

  # POST /credit_validations
  # POST /credit_validations.json
  def create
   if params[:existing_credit]
     @credit_validation = CreditValidation.new(params[:credit_validation])
     @current_credit = @credit_validation.current_credit_id
     @credit = Credit.find_by_id(@credit_validation.credit_id)
     @current_credit_validator = @credit.user_id
     @credit_validation.credit_id = @credit.id
     @credit_validation.user_id = @credit.user_id
     respond_to do |format|
       if @credit_validation.save
         CreditValidation.create(:credit_id => @current_credit, :user_id => current_user.id, :status => "pending", :validator_id => @current_credit_validator  )
          format.html { redirect_to :back, notice: "Credit Validation Request Sent."}
       else
         format.html { redirect_to :back }
          flash[:error] =  @credit_validation.errors.full_messages.each do |msg| msg.gsub(/\W+/, '')  end 
       
       
        
         format.json { render json: @credit_validation.errors, status: :unprocessable_entity }
       end
     end
   else
    @credit = Credit.find(params[:credit_id])
      @credit_validation = @credit.credit_validations.build(:credit_id => @credit.id)
        @credit_views = Credit.all
    
    respond_to do |format|
      if @credit_validation.save
        format.js
        format.html { redirect_to :back, notice: "Credit Validation Updated"}
      else
       format.html { redirect_to :back }
        flash[:error] =  @credit_validation.errors.full_messages.each do |msg| msg.gsub(/\W+/, '')  end 
          format.json { render json: @credit_validation.errors, status: :unprocessable_entity }
      end
    end
     end   
  end

  # PUT /credit_validations/1
  # PUT /credit_validations/1.json
  def update
    @credit_validation = CreditValidation.find(params[:id])

    respond_to do |format|
      if @credit_validation.update_attributes(params[:credit_validation])
        format.html { redirect_to @credit_validation, notice: 'Credit validation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
         flash[:error] =  @credit_validation.errors.full_messages.each do |msg| msg.gsub(/\W+/, '')  end 
       
       
       
        format.json { render json: @credit_validation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_validations/1
  # DELETE /credit_validations/1.json
  def destroy
    @credit_validation = CreditValidation.find(params[:id])
    @credit_validation.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
