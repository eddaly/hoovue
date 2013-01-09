class ApplicationController < ActionController::Base
  protect_from_forgery


protected

#Temp Security Attr
  if RAILS_ENV= "production"
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
                                              end
    end
 end


end
