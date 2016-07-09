Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :show, :new]
  resources :users, only: [:index, :edit, :show]
end
