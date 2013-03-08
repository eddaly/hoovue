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
    
     
  end
  
  def increase
    @credit = Credit.find(params[:id])
      @credit.increment! :count
        @credit_validation = CreditValidation.new(params[:credit_validation])
           @credit_validation.credit_id = @credit.id
             @credit_validation.user_id = current_user.id
         if @credit.update_attributes(params[:credit])
                @credit_validation.save!
      flash[:notice] = "Thank you for validating"
      redirect_to :back
    end
  end  

  def flag
    @credit = Credit.find(params[:id])
      @credit.status == "flagged"
      flash[:notice] = "Thank you we will look into it."
      redirect_to :back
  end

  # POST /credits
  # POST /credits.json
  def create 
    @credit = Credit.new(params[:credit])
      @credit.status = 'pending'
      respond_to do |format|
      if @credit.save
        if @credit.pending_user_email
       CreditMailer.new_credit(@credit).deliver
        end
        format.html { redirect_to :back, notice: 'Credit was successfully created.' }
        format.json { render json: @credit, status: :created, location: @credit }
      else
        format.html { render action: "new" }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
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
      format.html { redirect_to :back, notice: 'Credit deleted' }
      format.json { head :no_content }
    end
  end
end
