Rails.application.routes.draw do
  devise_for :users
  root 'prototypes/populars#index'

  namespace :prototypes do
    resources :newests, only: :index
    resources :populars, only: :index
  end

  resources :prototypes, except: :index do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :users, only: [:index, :edit, :show, :update]
  resources :tags ,param: :tag_name, only: [:index, :show]
end
