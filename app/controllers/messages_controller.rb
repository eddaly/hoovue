class MessagesController < ApplicationController

	before_filter :authorize

	def new
		@message = Message.new
	end

	def create
		@message = current_user.messages.create(params[:message].except(:recipient_name))
		if @message.save
			redirect_to root_url, :notice => "Message was sent successfully!"
		else
			render :new
		end
	end
end
