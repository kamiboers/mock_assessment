Rails.application.routes.draw do

  root 'links#index'

  get '/welcome' => 'pages#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/dashboard' => 'pages#dashboard', as: :dashboard
  get '/logout' => 'sessions#destroy'

resources :users, only: [:new, :create, :show]
resources :links
 
end
