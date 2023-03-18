Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root 'static_pages#home'
  resources :products
  get 'demo_partials/new'
  get 'demo_partials/edit'
  get 'static_pages/home'
  get 'static_pages/help'

  get '/signup', to: "users#new"
  post '/signup', to: "users#create"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, only: %i(new create edit update) 

  resources :microposts, only: %i(create destroy)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
