Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create, :show, :edit, :update]
  
  resources :chatrooms do
    member do
      get :users
    end
  end
  
  resources :user_chatrooms, only: [:create, :destroy]
  resources :questions
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end