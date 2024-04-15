Rails.application.routes.draw do
  get "follow_ups/send_follow_up_email"
  root to: "pages#landing"
  get "about", to: "pages#about"
  get "feedback", to: "pages#feedback"

  resources :ai_messages
  resources :job_listings do
    patch "update_status/:status", action: :update_status, on: :member, as: :update_status
    get "application_insights", action: :application_insights, on: :collection, as: :application_insights
  end
  resources :boards
  resources :interviews

  # devise_for :users, :controllers => { registrations: "users/registrations" }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # devise_for :users, controllers: { 
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  #   omniauth_callbacks: 'users/omniauth_callbacks'}

  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # devise_scope :user do
  #   get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  

  delete "users/remove_avatar", to: "users#remove_avatar", as: "remove_avatar"

# config/routes.rb
post "/follow_ups/send_follow_up_email", to: "follow_ups#send_follow_up_email"




  # mount RailsDb::Engine => '/rails/db', :as => 'rails_db'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
