Rails.application.routes.draw do

  get 'home/about'
  devise_for :users
  root to: "home#top"
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
