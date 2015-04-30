class CreditsController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => :search

  def index
    @credits = Credit.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credits }
    end
  end

  def recent
    @credits = Credit.recent.limit(25)
    @page_title = "Recent Credits"
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @credits }
    end
  end

  def import #Remove?
    Credit.import(params[:file])
    redirect_to root_url, notice: "credits imported."
  end

  def show
    @credit = Credit.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit }
    end
  end

  def new
    @credit = Credit.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit }
    end
  end

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
    if params[:search].blank?
      flash.now[:notice] = "You must search for Games or People"
      @products = []
      @users = []
    else
      @products = Product.search(params[:search]).page(params[:page])
      @users = User.search(params[:search]).page(params[:page])
    end

    if current_user 
      @credit = Credit.new
      @product = Product.new
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


  def create #Needs refactoring and moving

    #Init new credit pass params and defaults

    @credit = Credit.new(params[:credit])
    @credit.role = params[:role]
    @credit.source = "wa"
    @credit.confirmed_validations_count = 0 #Migration for default value
    @credit.credit_validation_count = 0 #Migration for default value
    #@credit.product_id = @credit.product_idd

    #Batch credit add - View now removed - Review with Ed 

    if params[:batch] #Can be removed?
      @credit.role = params[:role]
      @credit.product_id = params[:product_id]
      @credit.current_credit_role = params[:current_credit_role]
      @credit.user_id = current_user.id
    end

    #Set credit tokens 

    @credit.pending_token = SecureRandom.urlsafe_base64(20) #Create random pending token
    #if @credit.pending_user_email == current_user.email # Quick validation check
      #redirect_to :back, notice: 'You cannot validate yourself.'
    else
      if params[:facebook]
        @credit.validator_id = current_user.id
        @credit.pending_user_email = rand(10000...30000).to_i # Create random pending token
      end


      #if params[:email]
      #@credit.product_id = @credit.product_idd
      #end


      #Create new CV and set values

      @credit_validation = CreditValidation.new(params[:credit_validation])
      @credit_validation.status = "pending"
      @credit.validator_id = current_user.id
      @credit_validation.user_id = current_user.id #Redundant now? 
      @credit_validation.token = @credit.pending_user_email
      @credit_validation.validator_id = rand(10000...30000).to_i #Random so not nil
      @credit_validation.credit_id = @credit.current_credit_id

      respond_to do |format|
        if @credit.save
          if @credit_validation.save
            @credit.credit_validation_id = @credit_validation.id
            @credit.user_name = current_user.name
            @credit.update_attributes(params[:credit])
          end #DBNT

          if @credit.pending_user_email #Send alert if email
            CreditMailer.new_credit(@credit).deliver
          end

          if params[:batch] #Redundant? See above.
            format.html { redirect_to :back, notice: 'Credit was successfully created.' }
          end 

          if params[:facebook] #Facebook diag redirect. Replaced with FB inside app but removed due to permissions. Re-visit. 
            format.html { redirect_to ("https://www.facebook.com/dialog/send?app_id=#{ENV['FACEBOOK_APP_ID']}&name=whoactually.com%20credit%20-%20Get%20the%20recognition%20you%20deserve&description=As%20a%20co-creator%20on%20#{@credit.product.title},%20#{current_user.name}%20would%20like%20you%20to%20validate%20their%20credit.%20#{current_user.name}%20also%20recorded%20that%20you%20were%20#{@credit.role}.%20To%20validate%20this%20credit%20and%20claim%20your%20own%20follow%20this%20link.&link=http://#{ENV['DEFAULT_URL']}/credits/#{@credit.id}?pending_token=#{@credit.pending_token}&redirect_uri=http://#{ENV['DEFAULT_URL']}/users/#{current_user.id}")}
          end 

          #Redirect to suggested product
          #format.html  { redirect_to("/suggested?product_id=#{@credit.product_id}") }
          format.html { redirect_to(product_path @credit.product) }
        else
          flash[:error] =  @credit.errors.full_messages.each do |msg| msg.gsub(/\W+/, '')  end 
          format.html { redirect_to :back }
          format.json { render json: @credit.errors, status: :unprocessable_entity }
        end
      end
    #end
  end


  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])

        format.html { redirect_to user_path(current_user), notice: 'Your Credit has been updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Credit deleted' }
      format.json { head :no_content }
    end
  end


  def claim #Claim and rediect suggested credits
    Credit.update_all({user_id: @current_user.id, :confirmed_validations_count => "0", :source => "wa"}, {id: params[:credit_ids]})
    redirect_to :back
  end
end
