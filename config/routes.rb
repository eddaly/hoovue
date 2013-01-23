Hoo::Application.routes.draw do
  resources :credit_validations


  resources :credits do
     collection { post :import }
end


  resources :products do
  collection { post :import }
end


#Rails Admin
mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

 
#Session Routes
get "sessions/new"


#User Routes
resources :users
match 'auth/:provider/callback', to: 'sessions#create'
match 'auth/failure', to: redirect('/')
match 'signout', to: 'sessions#destroy', as: 'signout'

#Products
match '/rate' => 'rater#create', :as => 'rate'


#Temp 
get "holding/index"

root :to => "products#index"

 
end
