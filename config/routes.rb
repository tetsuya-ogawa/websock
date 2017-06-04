Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  get :signup, to: 'users#new'

  resources :sessions, only: :create
  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'
  resources :rooms
  root to: 'rooms#index'
end
