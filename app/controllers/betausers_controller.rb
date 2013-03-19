class BetausersController < ApplicationController
  def new
      @betauser = Betauser.new
    end

    def create
      @betauser = Betauser.new(params[:betauser])
      if @betauser.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render "new"
      end
    end
end
