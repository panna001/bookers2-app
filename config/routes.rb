Rails.application.routes.draw do

  get 'home/about'
  devise_for :users
  root to: "home#top"
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following
      get :follower
    end
  end
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  post "follow/:id" => "relationships#follow", as: "follow"
  post "unfollow/:id" => "relationships#unfollow", as: "unfollow"
  get "search" =>"search#search", as: "search"
end
