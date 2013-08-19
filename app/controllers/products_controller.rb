class ProductsController < ApplicationController

load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
     
    redirect_to root_url
  end
  
def import
  Product.import(params[:file])
  redirect_to root_url, notice: "Products imported."
end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @verified_credits = @product.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "3")
    @one_verified_credits = @product.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "1")
    @two_verified_credits = @product.credits.includes(:credit_validations).where("credit_validations.status = 'confirmed'").where(:credit_validation_count => "2")
    @part_verified_credits = @one_verified_credits.count + @two_verified_credits.count 
    @pending_credits = @product.credits.includes(:credit_validations).where("credit_validations.status = 'pending'")
    if params[:sort] == "verified"
     @credits = @product.credits.where("user_id > ?", 0).order("credit_validation_count DESC, created_at DESC")
   else
       @credits = @product.credits.where("user_id > ?", 0).order("credit_validation_count DESC, created_at DESC")
   
   end
        if current_user
        @user_credits = Credit.where(:user_id => current_user.id, :product_id => @product.id)
          @credit = Credit.new
             @credit_validation = CreditValidation.new
             @post = Post.new
          
        
      end  
  end

  # GET /products/new
  # GET /products/new.json
  def new
    if current_user
      
    begin
      if params[:name].empty?
          redirect_to search_credits_path , :notice => "Please select a category."
      else
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end
  rescue
    redirect_to search_credits_path 
  end
else
  redirect_to root_url, :notice => "Please login before making a new work."
end
  end

  # GET /products/1/edit
  def edit
     @product = Product.find(params[:id])
    if current_user.id == @product.user_id
   
  else
    redirect_to root_url, notice: 'You do not own this work.'
  end
end
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
      @product.user_id = current_user.id
        @credit = Credit.new(params[:credit])
          @credit.user_id = current_user.id
            @credit.role = @product.role
              @credit.role_desc = @product.role_description
                @credit.fact = @product.fact
                @credit.issue = @product.issue
                 @credit.count = "0"
    respond_to do |format|
      if @product.save
           @credit.product_id = @product.id
             @credit.save
        format.html { redirect_to @product, notice: 'Work was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Work and credit successfully created' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
