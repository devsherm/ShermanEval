Rails.application.routes.draw do
  # Admin only routes
  authenticate :user, ->(user) { user.admin? } do
    get 'job_applications', to: 'job_applications#index'
    get 'job_applications/:id/view', to: 'job_applications#view', as: 'view_job_application'
    patch 'job_applications/:id/view', to: 'job_applications#change_status', as: 'change_status'
  end

  # Only include the desired Devise modules and routes
  devise_for :users, skip: [:registrations]
  
  # Manually define the registrations routes you want to include, if any
  devise_scope :user do
    # Only include the registration route for new and create actions
    get 'users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post 'users', to: 'devise/registrations#create', as: :user_registration
  end

  resources :job_applications, only: [:new, :edit, :show, :create]
  patch '/job_applications', to: 'job_applications#update'

  # Defines the root path route ("/")
  root 'home#index'
end