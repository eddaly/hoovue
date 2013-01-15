class User < ActiveRecord::Base
 #Activemodel Password 
  has_secure_password
  
      attr_accessible :email, :provider, :uid, :oauth_token, :oauth_expires_at, :name, :password, :password_confirmation
  
  #User Validation      
  validates_uniqueness_of :email
  
  def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end
  
end
