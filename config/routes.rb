Rails.application.routes.draw do
  get '/top', to: 'homes#top'
  get '/about', to: 'homes#about'
  root 'tweets#index'
  devise_for :users
  resources :tweets do
  	resource :favorites, only: [:create, :destroy]
  	resource :comments, only: [:create, :destroy]
  end
  resources :users do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end
end