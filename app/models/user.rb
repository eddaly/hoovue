class User < ActiveRecord::Base

      attr_accessible :email, :provider, :uid, :bio, :link, :twitter, :facebook, :linkedin, :googleplus, :oauth_token, :oauth_expires_at, :profile_picture, :product_ids, :role, :name, :credits_count
        has_many :products
          has_many :credits
            has_many :posts
              has_many :friendships
                has_many :friends, :through => :friendships
           
            #Rating system
              letsrate_rater
              
              #Roles
                ROLES = %w[admin moderator user banned]
              
  #User Validation      
   # validates_uniqueness_of :email
  
  def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.profile_picture = auth.info.image
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.role = "user"
   
    user.save!
    
  end
end

def self.search(search)
  if search
     where('lower(name) LIKE lower(?)', "%#{search}%")                        
  else
    scoped
  end
end  


  
end
