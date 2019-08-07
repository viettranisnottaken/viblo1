Rails.application.routes.draw do
  get 'pages/home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  root 'pages#home'
  resources :users
  resources :requests
  namespace :admin do
  	resources :requests, only: [:edit, :update, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
