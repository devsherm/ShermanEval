Rails.application.routes.draw do
  
  devise_for :users

  namespace :admin do
    resources :applicants
  end

  resource :applicants, only: %i[:show update]

  root 'applicants#show'
end
