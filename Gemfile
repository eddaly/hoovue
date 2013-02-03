source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
gem 'sqlite3'
gem 'better_errors'
end

group :production do
gem  'activerecord-postgresql-adapter'
gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

#Custom Gems
gem 'cancan'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'carrierwave'
gem "mini_magick"
gem "fog", "~> 1.3.1"
gem 'omniauth-facebook'
gem "rails_admin", :git => "git://github.com/sferik/rails_admin.git" # Without Devise
gem 'client_side_validations'
gem 'awesome_nested_fields'
gem 'letsrate'
gem 'counter_culture', '~> 0.1.7'
gem 'honeybadger'
gem "select2-rails", "~> 3.2.1"

# To use ActiveModel has_secure_password
 gem 'bcrypt-ruby', '~> 3.0.0'

#Testing Gems
gem "rspec-rails", :group => [:test, :development]
group :development do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
