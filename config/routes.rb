Rails.application.routes.draw do
  get '/top', to: 'homes#top'
  get '/about', to: 'homes#about'
  root 'tweets#index'
  devise_for :users
  resources :tweets
  resources :users
end