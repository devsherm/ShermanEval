Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update]

  resources :questionnaires
  root 'welcome#index'
  post 'send_email', to: 'questionnaires#send_email'
  get 'welcome/spring_24_junior_rails_developer', to: 'welcome#spring_24_junior_rails_developer'
  match '*path', to: 'application#handle_routing_error', via: :all
end
