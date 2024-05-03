Rails.application.routes.draw do
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin_view#admin_view' 
    patch 'update', to: 'admin_view#update'
    post 'email', to: 'admin_view#email'
  end
  get 'questionnaire', to: 'questionnaire#questionnaire'
  post 'submit', to: 'questionnaire#create'
  get 'viewer', to: 'questionnaire#viewer'
  devise_for :users
  resources :users, only: %i[edit update]

  resources :applicants
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'welcome#spring_24_junior_rails_developer'
end
