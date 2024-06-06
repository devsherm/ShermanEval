Rails.application.routes.draw do
  devise_for :users
  
  resources :user_applications do
    member do
      patch :update_status
      post :email_applicant
    end
  end

  # Defines the root path route ("/")
  root 'user_applications#index'
end
