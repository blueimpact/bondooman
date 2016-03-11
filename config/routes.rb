Rails.application.routes.draw do
  root to: 'items#index'

  resources :genres
  resources :segments
  resources :items, only: [:index, :show]
  resources :shots, only: [:index, :show]
end
