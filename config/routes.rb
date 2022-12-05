Rails.application.routes.draw do
  devise_for :users

  get '/server_status', to: 'application#index'
  get '/', to: 'home#index'
  root to: "home#index"

  resources :themes, only: [:index, :show]
  resources :posts do 
    post '/liked', to: 'post#liked'
    resources :comments
  end
end
