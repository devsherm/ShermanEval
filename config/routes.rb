Rails.application.routes.draw do
  resources :applicants
  resources :users, only: %i[edit update]
 
  devise_for :users
 
  get 'welcome/spring_24_junior_rails_developer'

  root 'applicants#index'
end
