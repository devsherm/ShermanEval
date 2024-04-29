Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[edit update] do
  end
  resources :user_applications, only: %i[index edit update new create destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'user_applications#index'
end
