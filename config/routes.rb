Rails.application.routes.draw do
  root to: 'rankings#latest'

  resources :rankings, only: [:index, :show, :destroy] do
    collection do
      get :latest
    end
  end

  resources :genres
  resources :segments
  resources :items, only: [:index, :show]
  resources :shots, only: [:index, :show]
end
