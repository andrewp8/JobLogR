Rails.application.routes.draw do
  resources :boards
  mount RailsDb::Engine => '/rails/db', :as => 'rails_db'
  root to: "boards#index"
  
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
