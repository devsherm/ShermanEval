Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update]
  
  resources :job_applications do
    collection do
      get :submitted
    end
  end

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :users, param: :id do
      collection do
        get :review_applications
      end
      member do
        post :send_status_update_email
        get :user_application
        patch :update_status
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'welcome/spring_24_junior_rails_developer'

  # Defines the root path route ("/")
  root 'welcome#index'
end