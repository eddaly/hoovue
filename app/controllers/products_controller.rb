class ProductsController < ApplicationController

load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
     
      @products = Product.search(params[:search])
        @users = User.search(params[:search])
  respond_to do |format|
      format .js
      format.html # index.html.erb
      format.json {  render json: @products.map(&:id) }
    end
  end
  
def import
  Product.import(params[:file])
  redirect_to root_url, notice: "Products imported."
end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
     @credit_views = @product.credits.all
      
        if current_user
        @user_credits = Credit.where(:user_id => current_user.id, :product_id => @product.id)
          @credit = Credit.new
             @credit_validation = CreditValidation.new
        
      end  
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new(product_genre_id: params[:product_genre_id])
    @category = ProductGenre.find_by_id(params[:name])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
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
        format.html { redirect_to @product, notice: 'Work was successfully updated.' }
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
