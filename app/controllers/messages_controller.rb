class MessagesController < ApplicationController

	before_filter :authorize

	def new
		@message = Message.new
     session[:return_to] = params[:redirect]
	end

	def create
		@message = current_user.messages.create(params[:message].except(:recipient_name))
		if @message.save
			redirect_to ("/products/#{session[:return_to]}"), notice: "Message sent."
		else
			render :new
		end
	end
end
