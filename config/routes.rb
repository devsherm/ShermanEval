Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update]
  resources :surveys
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'welcome#index'
end
