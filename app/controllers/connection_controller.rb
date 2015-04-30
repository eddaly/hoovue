class ConnectionController < ApplicationController

  before_filter do |controller|
    controller.params[:name] = nil if params[:name].blank?
    controller.params[:name] ||= current_user.try(:name)
  end

  def index
    @users = User.search(params[:name] || current_user.name)
    @claimable_credits = @users.map{ |user| user.credits.claimable.all }.flatten.uniq
    @claimable_credits.delete_if{ |credit| credit.user == current_user } if current_user
  end

end
