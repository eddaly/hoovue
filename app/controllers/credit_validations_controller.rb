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

  # POST /credit_validations
  # POST /credit_validations.json
  def create
    @credit = Credit.find(params[:credit_id])
      @credit_validation = @credit.credit_validations.build(:credit_id => @credit.id)
        @credit_views = Credit.all
    respond_to do |format|
      if @credit_validation.save
        format.js
        flash[:notic] = "Credit Validated."
      else
        format.html { render action: "new" }
        format.json { render json: @credit_validation.errors, status: :unprocessable_entity }
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
        format.html { render action: "edit" }
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
      format.html { redirect_to credit_validations_url }
      format.json { head :no_content }
    end
  end
end
