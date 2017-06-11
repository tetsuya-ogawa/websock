Rails.application.routes.draw do
  get :scraping, to: 'scraping#index'
  post :scraping, to: 'scraping#create'
  get :signup, to: 'users#new'

  resources :sessions, only: :create
  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'
  resources :rooms do
    scope module: :rooms do
      resources :users, only: [:destroy]
      resource :users, only: [:create]
    end
  end
  root to: 'rooms#index'
  mount ActionCable.server => '/cable'
end
