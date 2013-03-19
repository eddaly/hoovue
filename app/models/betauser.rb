class Betauser < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password_confirmation, :password
  has_secure_password
   validates_presence_of :password, :on => :create
end
