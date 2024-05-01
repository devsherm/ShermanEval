Rails.application.routes.draw do
  devise_for :users
  
  resources :user_applications do
    member do
      patch :update_status
    end
  end

  resources :users, only: %i[edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'user_applications#index'
end
