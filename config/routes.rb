Rails.application.routes.draw do
  root to: 'rankings#index'

  resources :genres
  resources :segments
  resources :rankings, only: [:index, :show, :destroy]
  resources :items, only: [:index, :show]
  resources :shots, only: [:index, :show]
end
