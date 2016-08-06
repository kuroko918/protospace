Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes, except: :index do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :users, only: [:index, :edit, :show, :update]
end
