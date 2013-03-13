Hoo::Application.routes.draw do
  

  get "front/index"
  get "front/validate_email_credit"
  resources :friendships


  resources :posts


  resources :product_genres


  resources :credit_validations


  resources :credits do
     collection do
     post :import 
     match 'role'
     match 'search'
   end
   member do
     put :increase
     put :flag
   end
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
match 'users', to: 'users#index', as: 'users'


#Products
match '/rate' => 'rater#create', :as => 'rate'

#Search

match "search", to: 'search#index', :as => 'search'

#Temp 
get "holding/index"

#Front

match "legal", to: 'front#legal', :as => 'legal'
match "terms", to: 'front#terms', :as => 'terms'
match "privacy", to: 'front#legal', :as => 'privacy'

root :to => "front#index"

 
end
