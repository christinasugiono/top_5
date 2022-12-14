Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/components', to: "pages#component"
  get '/profile', to: "pages#profile"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :boards, except: [:destroy] do
    resources :contributions, only: [:index, :new, :create]
    resources :board_hashtags, only: [:create]
    resources :bookmarks, only: [:create]
  end

  resources :bookmarks, only: [:destroy]
  resources :board_hashtags, only: [:destroy]

  resources :contributions, only: [:show, :edit, :update] do
    resources :points, only: [:create]
  end

  resources :points, only: [:destroy]

  resources :hashtags, only: [:show, :create]
end
