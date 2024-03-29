Rails.application.routes.draw do
  root to: "pages#landing"
  
  resources :job_listings
  resources :boards
  resources :interviews
  
  devise_for :users
  # mount RailsDb::Engine => '/rails/db', :as => 'rails_db'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"

end
