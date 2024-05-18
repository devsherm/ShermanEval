Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[edit update]
  resources :applicants, :shallow => false do
    resources :answers
    resources :categories
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'welcome/spring_24_junior_rails_developer'

  get '/applicants', to: 'applicants#index'
  get '/applicants/new'
  get '/applicants/:id', to: 'applicants#show'
  post '/applicants/:id/categories', to: 'categories#create'

  # Defines the root path route ("/")
  root 'welcome#index'
end
