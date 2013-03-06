Hoo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  
   
 #Facebook
  
  ENV['FACEBOOK_APP_ID'] = "409064285834455"
  
  ENV['FACEBOOK_SECRET'] = "f63033cdbe18abf335942654c953d45e"
  
  ENV['rel'] = "12345"
  
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  
      config.action_mailer.default_url_options = { :host => "localhost:3000" }
  
          #SMTP settings
            
              config.action_mailer.delivery_method = :smtp
          
                #Gmail Settings
                    
                    config.action_mailer.smtp_settings = { 
                  :address => "smtp.gmail.com",
                  :port => 587, 
                  :domain => "gmail.com",
                  :authentication => 'plain',
                  :user_name => 'hoovue@beo.so',
                  :password => 'waterloo12',
                  :enable_starttls_auto => true
                }

  

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
