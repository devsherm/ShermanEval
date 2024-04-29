Rails.application.routes.draw do
  
  devise_for :users

  authenticated :user, ->(user) { user.admin? } do
    root 'admin/applicants#index', as: :admin_root
  end

  authenticated :user do
    root 'applicants#show', as: :authenticated_root
  end

  namespace :admin do
    resources :applicants
  end

  resources :users, only: %i[edit update]
  resource :applicants, only: %i[:show update]

  root 'applicants#show'
end
