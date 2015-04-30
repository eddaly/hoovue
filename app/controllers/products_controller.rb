class ProductsController < ApplicationController

  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    @products = Product.order(:title).page(params[:page])
  end

  def popular
    @products = Product.popular.limit(25) # .page(params[:page])
    @page_title = "Popular Projects"
    render :index
  end

  def recent
    @page_title = "Recent Projects"
    @products = Product.recent.limit(25) #.page(params[:page])
    render :index
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: "Products imported."
  end

  #def like
    #@product = Product.find(params[:id])

    #if @current_user.flagged?(@product, :like)
      #@current_user.unflag(@product, :like)
      #msg = "Work Unliked"
    #else
      #@current_user.flag(@product, :like)
      #msg = "Work Liked"
    #end
    #redirect_to @product, :notice => msg
  #end

  #def complete
    #@product = Product.find(params[:id])

    #if @current_user.flagged?(@product, :complete)
      #@current_user.unflag(@product, :complete)
      #msg = "Vote Deleted"
    #else
      #@current_user.flag(@product, :complete)
      #msg = "You have voted this team is complete"
    #end
    #redirect_to @product, :notice => msg
  #end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @credits = @product.credits.wa_source.order("confirmed_validations_count, credit_validation_count, updated_at DESC").includes(:credit_validations).includes(:user).includes(:posts)
    #@credits_with_facts = @credits.where("fact IS NOT NULL OR fact != ''")
    @related_products = Product.where(:id != @product.id).where(:developed_by => @product.developed_by).limit(10)
    @rec_products = Product.uniq.where(:id => 10..20)

    if current_user
      @credit = @product.credits.build user: current_user
      @credit_validation = CreditValidation.new
      @post = Post.new
      @user_credits = @credits.where(:user_id => current_user.id)
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    redirect_to root_url, notice: "Please login before making a new work." and return unless current_user

    @product = Product.new
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
    @product = Product.new(params[:product].merge(genre: "Game"))
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
        format.html { redirect_to @product, notice: 'Work successfully updated.' }
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


  def invite
    @product = Product.find(params[:id])

    begin
      ProductMailer.invite_to_team(@product, current_user, params[:email]).deliver
    rescue e
    end

    respond_to do |format|
      format.html { redirect_to @product, notice: "Email sent" }
      format.json { head :no_content}
    end
  end

end
