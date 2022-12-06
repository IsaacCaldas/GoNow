Rails.application.routes.draw do
  devise_for :users

  get '/server_status', to: 'application#index'
  get '/', to: 'home#index'
  root to: 'home#index'

  resources :themes, only: %i[index show destroy]

  resources :posts do
    post '/liked', to: 'post#liked'
    resources :comments do
      post '/liked', to: 'comment#liked'
    end
  end

  resources :chats, only: %i[show] do
    resources :messages, only: %i[create destroy]
  end

  resources :user_chats, only: %i[index show create]
end
