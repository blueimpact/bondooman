Rails.application.routes.draw do
  root to: 'rankings#latest'

  get '/auth/:provider/callback' => 'session#create'
  get '/auth/failure'            => 'session#create'
  get '/session/'                => 'session#index',   as: :login
  delete '/session/logout'       => 'session#destroy', as: :logout

  resources :rankings, only: [:index, :show, :destroy] do
    collection do
      get :latest
      get ':platform/:genre/:segment', action: 'transition', as: 'transition'
    end
  end

  resources :genres
  resources :segments
  resources :items, only: [:index, :show]
  resources :shots, only: [:index, :show]
  resources :formatters
  resources :fetchers, only: [:index]
  resources :item_fetchers
  resources :ranking_fetchers

  unless Rails.env.test?
    require 'sidekiq/web'
    admin_constraint = -> (request) {
      request.session[:user_role] == 'admin'
    }
    constraints admin_constraint do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
end
