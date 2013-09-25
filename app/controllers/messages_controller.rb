class MessagesController < ApplicationController

	before_filter :authorize

	def new
		@message = Message.new
     session[:return_to] = params[:redirect]
	end

	def create
		@message = current_user.messages.create(params[:message].except(:recipient_name))
  
		if @message.save
      if @message.email
      @user = current_user
      @url = @message.url
      UserMailer.share(@user, @url).deliver
      end
       if @message.url.nil?
        redirect_to user_path(current_user.id), notice: "Message sent."
       else 
			redirect_to @message.url, notice: "Message sent."
    end
		else
			render :new
		end
	end
end
