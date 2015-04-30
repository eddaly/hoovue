Hoo::Application.routes.draw do
  



  get "connection/index", as: :connections
  

  resources :platforms


  get "beta/index"

  get "beta/work"

  get "beta/user"
  
  get "beta/add_credit"
  
  get "front/stats"

  resources :emails


  get "front/index"
  get "front/validate_email_credit"
  get "front/validate_new_email_credit"
  resources :betausers
  
  resources :betasessions
  
  resources :friendships
  resources :messages

  resources :posts


  resources :product_genres


  resources :credit_validations do
    member do
      put :validate
      put :flag
      put :validation
    end
  end


  resources :credits do
    collection do
      get :recent
      post :import 
      match 'role'
      match 'search'
      match 'batch'
      put :claim
    end
    member do
      put :increase
      put :flag
      put :claim
    end
  end


  resources :products, execpt: [:index, :destroy] do

    member do
      post :invite
    end

    collection do
      get :recent
      get :popular
    end
    #member do
    #get 'like'
    #get 'complete'
    #end
  end


#Rails Admin
mount RailsAdmin::Engine => '/lecrabe', :as => 'rails_admin'


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

match "message_preview", to: 'credits#validate-message', :as => 'message_preview'
#Front

match "legal", to: 'front#legal', :as => 'legal'
get :terms, to: "front#terms"
get :privacy, to: "front#privacy"
match "suggested", to: 'front#suggested', :as => 'suggested'

root :to => "beta#index"

 
end
