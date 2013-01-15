Hoo::Application.routes.draw do
 
  
#Rails Admin
mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

#Temp
root :to => 'holding#index'
 
 
#Session Routes
get "sessions/new"


#User Routes
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'


#Temp 
get "holding/index"

 
end
