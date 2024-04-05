Rails.application.routes.draw do
  resources :ai_messages
  root to: "pages#landing"

  resources :job_listings do
    patch 'update_status/:status', action: :update_status, on: :member, as: :update_status
    get 'graph', action: :graph, on: :collection, as: :graph
  end
  resources :boards
  resources :interviews

  devise_for :users, :controllers => {registrations: 'users/registrations'}
  delete 'users/remove_avatar', to: 'users#remove_avatar', as: 'remove_avatar'
  # mount RailsDb::Engine => '/rails/db', :as => 'rails_db'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
