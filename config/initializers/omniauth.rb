OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
   	:scope => 'xmpp_login'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "7xlvt2s361wr", "91EYzutUxFmDGvaQ"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['5tn1gP09AW3S9owPymaHVw'], ENV['nNoXAdbKT3sOAYzH7G8OG8B0m0KuxN1BJAxQVdU9k']
end