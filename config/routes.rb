Rails.application.routes.draw do
  root 'links#index'

  get '/welcome' => 'pages#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/dashboard' => 'pages#dashboard', as: :dashboard
  get '/logout' => 'sessions#destroy'
  get '/api/v1/links/' => 'api/v1/links#index'
  get '/api/v1/links/:id' => 'api/v1/links#update'
  get '/api/v1/alpha/' => 'api/v1/links#alpha'

resources :users, only: [:new, :create, :show]
resources :links
 
end
