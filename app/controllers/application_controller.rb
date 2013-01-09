class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

protected

#Temp Security Attr
  if RAILS_ENV= "development"
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "waterloo12"
                                              end
    end
 end


end
