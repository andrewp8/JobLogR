Rails.application.routes.draw do
  resources :interviews
  root to: "boards#index"
  # mount RailsDb::Engine => '/rails/db', :as => 'rails_db'
  
  devise_for :users
  resources :job_listings
  resources :boards
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
