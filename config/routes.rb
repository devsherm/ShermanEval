Rails.application.routes.draw do
  resources :applicants, only: %i[index edit update delete]
  devise_for :users

  resources :users, only: %i[edit update] do
    resources :applicants, only: %i[new create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'applicants#index'
end
