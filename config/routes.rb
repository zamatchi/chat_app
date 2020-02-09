Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  
  resources :users, only: [:new, :create, :show, :edit, :update] do
    member do
      # get :favorites
      get :myrooms
    end
  end

  resources :questions do
    resources :answers, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :chatrooms
  resources :user_chatrooms, only: [:create, :destroy]
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end