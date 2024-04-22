Rails.application.routes.draw do
  get "follow_ups/send_follow_up_email"
  get "about", to: "pages#about"
  get "feedback", to: "pages#feedback"
  
  resources :ai_messages
  resources :job_listings do
    patch "update_status/:status", action: :update_status, on: :member, as: :update_status
    get "application_insights", action: :application_insights, on: :collection, as: :application_insights
  end
  resources :boards
  resources :interviews
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  delete "users/remove_avatar", to: "users#remove_avatar", as: "remove_avatar"
  
  post "/follow_ups/send_follow_up_email", to: "follow_ups#send_follow_up_email"

  root to: "pages#landing"
end
