Rails.application.routes.draw do
  devise_for :users
  get 'edit_profile', to: 'users#edit'
  resources :users, only: %i[edit update]
  resources :surveys, only: %i[show new create]
  namespace :admin do
    resources :surveys
  end
  get 'admin', to: 'admin/surveys#index'
  get 'admin/surveys/deny/:id', to: 'admin/surveys#deny', as: 'admin_deny_survey'
  get 'admin/surveys/hold/:id', to: 'admin/surveys#hold', as: 'admin_hold_survey'
  get 'admin/surveys/approve/:id', to: 'admin/surveys#approve', as: 'admin_approve_survey'
  get 'admin/surveys/reset/:id', to: 'admin/surveys#reset', as: 'admin_reset_survey'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'welcome#index'
end
