Rails.application.routes.draw do
  root to: "boards#index"
  # mount RailsDb::Engine => '/rails/db', :as => 'rails_db'
  
  devise_for :users
  resources :job_listings
  resources :boards
  resources :interviews
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
